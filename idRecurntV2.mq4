//+------------------------------------------------------------------+
//|                                                         tzV1.mq4 |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
#property indicator_chart_window
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

//--- indicator settings
#property indicator_chart_window
#property indicator_buffers 2

#property indicator_type1 DRAW_ARROW
#property indicator_width1 1
#property indicator_color1 0xFFAA00
#property indicator_label1 "Buy"

#property indicator_type2 DRAW_ARROW
#property indicator_width2 1
#property indicator_color2 0x1A00FF
#property indicator_label2 "Buy"
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
double Buffer1[];
double Buffer2[];
datetime LastActionTime = 0;
int envtn1;
int evnt2;
double myPoint; //initialized in OnInit

 int OnInit()
  {   
   IndicatorBuffers(2);
   SetIndexBuffer(0, Buffer1);
   SetIndexEmptyValue(0, EMPTY_VALUE);
   SetIndexArrow(0, 241);
   SetIndexBuffer(1, Buffer2);
   SetIndexEmptyValue(1, EMPTY_VALUE);
   SetIndexArrow(1, 242);
   //initialize myPoint
   myPoint = Point();
   if(Digits() == 5 || Digits() == 3)
     {
      myPoint *= 10;
     }
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
     int limit = rates_total - prev_calculated;
   //--- counting from 0 to rates_total
   ArraySetAsSeries(Buffer1, true);
   ArraySetAsSeries(Buffer2, true);
   //--- initial zero
   if(prev_calculated < 1)
     {
      ArrayInitialize(Buffer1, EMPTY_VALUE);
      ArrayInitialize(Buffer2, EMPTY_VALUE);
     }
   else
      limit++;
      
        for(int i = limit-1; i >= 0; i--)
        {
         if (i >= MathMin(4800-1, rates_total-1-50)) continue; //omit some old rates to prevent "Array out of range" or slow calculation   
       
             datetime M5 = iTime(NULL, PERIOD_M15, iBarShift(Symbol(), PERIOD_M15, Time[i+1]));
              int mainx = iBarShift(NULL,PERIOD_M5,M5);
                int lwostCi ;
             if (LastActionTime != M5)
                 {
                    if(iHigh(NULL,PERIOD_M15,i+2) > iHigh(NULL,PERIOD_M15,i+3) && iHigh(NULL,PERIOD_M15,i+2) < iHigh(NULL,PERIOD_M15,i+4))
                     {
                       if(iLow(NULL,PERIOD_M5,mainx ) < iLow(NULL,PERIOD_M5,mainx+1) && iLow(NULL,PERIOD_M5,mainx) > iLow(NULL,PERIOD_M5,mainx+2))
                        {
                        envtn1++;
                         Buffer2[i+1] = iLow(NULL,PERIOD_M15,i+1);
      
                        }  
                     
                      
                     }
                 }
          
                   
                            
            Comment("Repaints: " + envtn1 + "\n Non: " + evnt2 );
         /*
          datetime M5 = iTime(NULL, PERIOD_M5, iBarShift(Symbol(), PERIOD_M5, Time[i]));
             datetime M5 = iTime(NULL, PERIOD_M15, iBarShift(Symbol(), PERIOD_M15, Time[i+1]));
              int mainx = iBarShift(NULL,PERIOD_M5,M5);
                int lwostCi ;
             if (LastActionTime != M5)
           {
       
                int mainx = iBarShift(NULL,PERIOD_M5,M15);
                int lwostCi ;
           if (LastActionTime != M5)
           {
            LastActionTime = M5;
            
                if(iHigh(NULL,PERIOD_M5,mainx) > iHigh(NULL,PERIOD_M5,mainx-1) && iHigh(NULL,PERIOD_M5,mainx) > iHigh(NULL,PERIOD_M5,mainx +1))
                  {
                  
                   //  Buffer1[i+1] = High[i+1];
                  }
                         
               if(iLow(NULL,PERIOD_M5,mainx) < iLow(NULL,PERIOD_M5,mainx-1)&& iLow(NULL,PERIOD_M5,mainx)< iLow(NULL,PERIOD_M5,mainx +1 )&& iLow(NULL,PERIOD_M5,mainx)> iLow(NULL,PERIOD_M5,mainx+2))
                  {
                           
                  }
           if(High[i+1] > High[i+2] && High[i+1] < High[i+3])
              {
               datetime M15 = iTime(NULL, PERIOD_M15, iBarShift(Symbol(), PERIOD_M15, Time[i+1]));
                int mainx = iBarShift(NULL,PERIOD_M5,M15);
                int lwostCi ;
                for(int i=0;i<1;i++)
                  {
                if(iHigh(NULL,PERIOD_M5,mainx) < iHigh(NULL,PERIOD_M5,mainx-i))
                  {
                   lwostCi = mainx -i;
                  }
                  else
                    {
                     
                    }   
                  }
                
              }
                   /*  if(iHigh(NULL,PERIOD_M5,mainx) > iHigh(NULL,PERIOD_M5,mainx-1) && iHigh(NULL,PERIOD_M5,mainx) > iHigh(NULL,PERIOD_M5,mainx +1) && iHigh(NULL,PERIOD_M5,mainx)< iHigh(NULL,PERIOD_M5,mainx+2))
                              {
                            
                              }
                              */
           
           }
         
        
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
