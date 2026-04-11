
with Group_A;
with Group_CXA;
with Group_CXB;

with CXF1001;
with CXF2001;
with CXF2002;
with CXF2003;
with CXF2004;
with CXF2005;
with CXF2A01;
with CXF2A02;
--  with CXF3001;
--  with CXF3002;
--  with CXF3003;
--  with CXF3004;
--  with CXF3A01;
--  with CXF3A02;
--  with CXF3A03;
--  with CXF3A04;
--  with CXF3A05;
--  with CXF3A06;
--  with CXF3A07;
--  with CXF3A08;

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
   Group_CXA;
   Group_CXB;

   CXF1001;
   CXF2001;
   CXF2002;
   CXF2003;
   CXF2004;
   CXF2005;
   CXF2A01;
   CXF2A02;
   --  CXF3001;
   --  CXF3002;
   --  CXF3003;
   --  CXF3004;
   --  CXF3A01;
   --  CXF3A02;
   --  CXF3A03;
   --  CXF3A04;
   --  CXF3A05;
   --  CXF3A06;
   --  CXF3A07;
   --  CXF3A08;

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
