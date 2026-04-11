
with Group_A;
with Group_C2;
with Group_C3;
with Group_CXA;
with Group_CXB;
with Group_CXC;
with Group_CXF;

with CXG1001;
with CXG1002;
--  with CXG1003;
with CXG1004;
with CXG1005;
with CXG2001;
with CXG2002;
with CXG2003;
with CXG2004;
with CXG2005;
with CXG2006;
with CXG2007;
with CXG2008;
with CXG2009;
with CXG2010;
with CXG2011;
with CXG2012;
with CXG2013;
with CXG2014;
with CXG2015;
with CXG2016;
with CXG2017;
with CXG2018;
with CXG2019;
with CXG2020;
with CXG2021;
with CXG2022;
with CXG2023;
with CXG2024;

with Debug;

procedure Main is
   procedure ESP_Restart
     with Import, Convention => C, External_Name => "esp_restart";

begin
   Debug.Print_Heap_Info;
   Debug.Install_Heap_Failed_Alloc_Callback;

   Group_A;
   Group_C2;
   Group_C3;
   Group_CXA;
   Group_CXB;
   Group_CXC;
   Group_CXF;

   CXG1001;
   CXG1002;
   --  CXG1003;
   CXG1004;
   CXG1005;
   CXG2001;
   CXG2002;
   CXG2003;
   CXG2004;
   CXG2005;
   CXG2006;
   CXG2007;
   CXG2008;
   CXG2009;
   CXG2010;
   CXG2011;
   CXG2012;
   CXG2013;
   CXG2014;
   CXG2015;
   CXG2016;
   CXG2017;
   CXG2018;
   CXG2019;
   CXG2020;
   CXG2021;
   CXG2022;
   CXG2023;
   CXG2024;

   Debug.Print_Heap_Info;
   ESP_Restart;
end Main;
