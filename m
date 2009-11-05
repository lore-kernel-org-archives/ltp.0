Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1N63Uj-00078h-9f
	for ltp-list@lists.sourceforge.net; Thu, 05 Nov 2009 14:39:25 +0000
Received: from relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 4E0B074609
	for <ltp-list@lists.sourceforge.net>;
	Thu,  5 Nov 2009 15:39:11 +0100 (CET)
Date: Thu, 5 Nov 2009 15:39:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091105143910.GA18828@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
Subject: [LTP] [PATCH] rename coliding names in runtest files
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Following patch renumbers testcase names in runtest/ltp-aio-stress.part1 and
runtest/ltp-aio-stress.part2 so that their names don't collide. Also renames
testcases in runtest/ltp-aiodio.part2 so that they don't collide with
ltp-aio-stress ones.

Signed-off-by: chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--huq684BweRXVnRxX
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="rename-testcases-in-runtest-files.patch"

Index: ltp-full-20090430/runtest/ltp-aio-stress.part1
===================================================================
--- ltp-full-20090430.orig/runtest/ltp-aio-stress.part1
+++ ltp-full-20090430/runtest/ltp-aio-stress.part1
@@ -26,55 +26,54 @@
 #       -x turn off thread stonewalling
 #       -h this message
 #
-ADS000 aio-stress -I500  -o2 -S -r4   /test/aiodio/file1 
-ADS001 aio-stress -I500  -o2 -S -r8   /test/aiodio/file1
-ADS002 aio-stress -I500  -o2 -S -r16  /test/aiodio/file1 
-ADS003 aio-stress -I500  -o2 -S -r32  -t2  /test/aiodio/junkfile /test/aiodio/file2
-ADS004 aio-stress -I500  -o2 -S -r64   /test/aiodio/junkfile /test/aiodio/file2 
-ADS005 aio-stress -I500  -o3 -S -r4    /test/aiodio/junkfile /test/aiodio/file2 
-ADS006 aio-stress -I500  -o3 -S -r8   -t2  /test/aiodio/junkfile /test/aiodio/file2 
-ADS007 aio-stress -I500  -o3 -S -r16  -t2  /test/aiodio/junkfile /test/aiodio/file2      
-ADS008 aio-stress -I500  -o3 -S -r32  -t4  /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file3  /test/aiodio/file4       
-ADS009 aio-stress -I500  -o3 -S -r64  -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4        
-ADS010 aio-stress -I500  -o3 -S -r128 -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4    
-ADS011 aio-stress -I500  -o3 -S -r256 -t8  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4 /test/aiodio/file5  /test/aiodio/file6 /test/aiodio/file7  /test/aiodio/file8
-ADS012 aio-stress -I500  -o3 -S -r512 -t8  /test/aiodio/junkfile /test/aiodio/file2 /test/aiodio/file3  /test/aiodio/file4 /test/aiodio/file5  /test/aiodio/file6 /test/aiodio/file7  /test/aiodio/file8
-ADS013 aio-stress -I500  -o2 -O -r4    -t8  /test/aiodio/junkfile /test/aiodio/file2 /test/aiodio/file3  /test/aiodio/file4 /test/aiodio/file5  /test/aiodio/file6 /test/aiodio/file7  /test/aiodio/file8
-ADS014 aio-stress -I500  -o2 -O -r8         /test/aiodio/file1 /test/aiodio/file2            
-ADS015 aio-stress -I500  -o2 -O -r16        /test/aiodio/file1 /test/aiodio/file2         
-ADS016 aio-stress -I500  -o2 -O -r32   -t2  /test/aiodio/junkfile /test/aiodio/file2 
-ADS017 aio-stress -I500  -o2 -O -r64   -t2  /test/aiodio/junkfile /test/aiodio/file2 
-ADS018 aio-stress -I500  -o3 -O -r4    -t2  /test/aiodio/junkfile /test/aiodio/file2 
-ADS019 aio-stress -I500  -o3 -O -r8    -t2  /test/aiodio/junkfile /test/aiodio/file2 
-ADS020 aio-stress -I500  -o3 -O -r16   -t2  /test/aiodio/junkfile /test/aiodio/file2 
-ADS021 aio-stress -I500  -o3 -O -r32   -t4  /test/aiodio/junkfile /test/aiodio/file2       /test/aiodio/file7  /test/aiodio/file8     
-ADS022 aio-stress -I500  -o3 -O -r64   -t4  /test/aiodio/junkfile /test/aiodio/file2    /test/aiodio/file7  /test/aiodio/file8   
-ADS023 aio-stress -I500  -o3 -O -r128  -t4  /test/aiodio/junkfile /test/aiodio/file2    /test/aiodio/file7  /test/aiodio/file8  
-ADS024 aio-stress -I500  -o3 -O -r256  -t8  /test/aiodio/junkfile /test/aiodio/file2    /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file4  /test/aiodio/file3  /test/aiodio/file5  /test/aiodio/file6 
-ADS025 aio-stress -I500  -o3 -O -r512  -t8  /test/aiodio/junkfile /test/aiodio/file2 /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6 
-ADS026 aio-stress -I500  -o0 -S -r4    -t8  /test/aiodio/junkfile /test/aiodio/file2       /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6    
-ADS027 aio-stress -I500  -o0 -S -r8           /test/aiodio/file2            
-ADS028 aio-stress -I500  -o0 -S -r16          /test/aiodio/file2         
-ADS029 aio-stress -I500  -o0 -S -r32   -t2    /test/aiodio/junkfile /test/aiodio/file2         
-ADS030 aio-stress -I500  -o0 -S -r64   -t2    /test/aiodio/junkfile /test/aiodio/file2         
-ADS031 aio-stress -I500  -o1 -S -r4    -t2    /test/aiodio/junkfile /test/aiodio/file2         
-ADS032 aio-stress -I500  -o1 -S -r8    -t2    /test/aiodio/junkfile /test/aiodio/file2      
-ADS033 aio-stress -I500  -o1 -S -r16   -t2    /test/aiodio/junkfile /test/aiodio/file2      
-ADS034 aio-stress -I500  -o1 -S -r32   -t4    /test/aiodio/junkfile /test/aiodio/file2        /test/aiodio/file7  /test/aiodio/file8                                                                               
-ADS035 aio-stress -I500  -o1 -S -r64   -t4    /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8                                                                               
-ADS036 aio-stress -I500  -o1 -S -r128  -t4    /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8                                                                               
-ADS037 aio-stress -I500  -o1 -S -r256  -t8  /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file4  /test/aiodio/file3  /test/aiodio/file5  /test/aiodio/file6
-ADS038 aio-stress -I500  -o1 -S -r512  -t8  -x /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
-ADS039 aio-stress -I500  -o1 -O -r4    -t8  -x  /test/aiodio/junkfile /test/aiodio/file2        /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
-ADS040 aio-stress -I500  -o1 -O -r8    -t2  -x /test/aiodio/junkfile /test/aiodio/file2         
-ADS041 aio-stress -I500  -o1 -O -r16   -t2  -x  /test/aiodio/junkfile /test/aiodio/file2         
-ADS042 aio-stress -I500  -o1 -O -r32   -t2   /test/aiodio/junkfile /test/aiodio/file2      
-ADS043 aio-stress -I500  -o1 -O -r64   -t2   /test/aiodio/junkfile /test/aiodio/file2      
-ADS044 aio-stress -I500  -o1 -O -r4    -t4   /test/aiodio/junkfile /test/aiodio/file2        /test/aiodio/file7  /test/aiodio/file8                                                                               
-ADS045 aio-stress -I500  -o1 -O -r8    -t4   /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8                                                                               
-ADS046 aio-stress -I500  -o1 -O -r16   -t4   /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8                                                                               
-ADS047 aio-stress -I500  -o1 -O -r32   -t8   /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file4  /test/aiodio/file3  /test/aiodio/file5  /test/aiodio/file6
-ADS048 aio-stress -I500  -o1 -O -r64   -t8   /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
-ADS049 aio-stress -I500  -o1 -O -r128  -t8   /test/aiodio/junkfile /test/aiodio/file2        /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
-ADS050 aio-stress -I500  -o1 -O -r256  -t2   /test/aiodio/junkfile /test/aiodio/file2         
-                                                        
+ADS1000 aio-stress -I500  -o2 -S -r4   /test/aiodio/file1 
+ADS1001 aio-stress -I500  -o2 -S -r8   /test/aiodio/file1
+ADS1002 aio-stress -I500  -o2 -S -r16  /test/aiodio/file1 
+ADS1003 aio-stress -I500  -o2 -S -r32  -t2  /test/aiodio/junkfile /test/aiodio/file2
+ADS1004 aio-stress -I500  -o2 -S -r64   /test/aiodio/junkfile /test/aiodio/file2 
+ADS1005 aio-stress -I500  -o3 -S -r4    /test/aiodio/junkfile /test/aiodio/file2 
+ADS1006 aio-stress -I500  -o3 -S -r8   -t2  /test/aiodio/junkfile /test/aiodio/file2 
+ADS1007 aio-stress -I500  -o3 -S -r16  -t2  /test/aiodio/junkfile /test/aiodio/file2      
+ADS1008 aio-stress -I500  -o3 -S -r32  -t4  /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file3  /test/aiodio/file4       
+ADS1009 aio-stress -I500  -o3 -S -r64  -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4        
+ADS1010 aio-stress -I500  -o3 -S -r128 -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4    
+ADS1011 aio-stress -I500  -o3 -S -r256 -t8  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4 /test/aiodio/file5  /test/aiodio/file6 /test/aiodio/file7  /test/aiodio/file8
+ADS1012 aio-stress -I500  -o3 -S -r512 -t8  /test/aiodio/junkfile /test/aiodio/file2 /test/aiodio/file3  /test/aiodio/file4 /test/aiodio/file5  /test/aiodio/file6 /test/aiodio/file7  /test/aiodio/file8
+ADS1013 aio-stress -I500  -o2 -O -r4    -t8  /test/aiodio/junkfile /test/aiodio/file2 /test/aiodio/file3  /test/aiodio/file4 /test/aiodio/file5  /test/aiodio/file6 /test/aiodio/file7  /test/aiodio/file8
+ADS1014 aio-stress -I500  -o2 -O -r8         /test/aiodio/file1 /test/aiodio/file2            
+ADS1015 aio-stress -I500  -o2 -O -r16        /test/aiodio/file1 /test/aiodio/file2         
+ADS1016 aio-stress -I500  -o2 -O -r32   -t2  /test/aiodio/junkfile /test/aiodio/file2 
+ADS1017 aio-stress -I500  -o2 -O -r64   -t2  /test/aiodio/junkfile /test/aiodio/file2 
+ADS1018 aio-stress -I500  -o3 -O -r4    -t2  /test/aiodio/junkfile /test/aiodio/file2 
+ADS1019 aio-stress -I500  -o3 -O -r8    -t2  /test/aiodio/junkfile /test/aiodio/file2 
+ADS1020 aio-stress -I500  -o3 -O -r16   -t2  /test/aiodio/junkfile /test/aiodio/file2 
+ADS1021 aio-stress -I500  -o3 -O -r32   -t4  /test/aiodio/junkfile /test/aiodio/file2       /test/aiodio/file7  /test/aiodio/file8     
+ADS1022 aio-stress -I500  -o3 -O -r64   -t4  /test/aiodio/junkfile /test/aiodio/file2    /test/aiodio/file7  /test/aiodio/file8   
+ADS1023 aio-stress -I500  -o3 -O -r128  -t4  /test/aiodio/junkfile /test/aiodio/file2    /test/aiodio/file7  /test/aiodio/file8  
+ADS1024 aio-stress -I500  -o3 -O -r256  -t8  /test/aiodio/junkfile /test/aiodio/file2    /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file4  /test/aiodio/file3  /test/aiodio/file5  /test/aiodio/file6 
+ADS1025 aio-stress -I500  -o3 -O -r512  -t8  /test/aiodio/junkfile /test/aiodio/file2 /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6 
+ADS1026 aio-stress -I500  -o0 -S -r4    -t8  /test/aiodio/junkfile /test/aiodio/file2       /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6    
+ADS1027 aio-stress -I500  -o0 -S -r8           /test/aiodio/file2            
+ADS1028 aio-stress -I500  -o0 -S -r16          /test/aiodio/file2         
+ADS1029 aio-stress -I500  -o0 -S -r32   -t2    /test/aiodio/junkfile /test/aiodio/file2         
+ADS1030 aio-stress -I500  -o0 -S -r64   -t2    /test/aiodio/junkfile /test/aiodio/file2         
+ADS1031 aio-stress -I500  -o1 -S -r4    -t2    /test/aiodio/junkfile /test/aiodio/file2         
+ADS1032 aio-stress -I500  -o1 -S -r8    -t2    /test/aiodio/junkfile /test/aiodio/file2      
+ADS1033 aio-stress -I500  -o1 -S -r16   -t2    /test/aiodio/junkfile /test/aiodio/file2      
+ADS1034 aio-stress -I500  -o1 -S -r32   -t4    /test/aiodio/junkfile /test/aiodio/file2        /test/aiodio/file7  /test/aiodio/file8                                                                               
+ADS1035 aio-stress -I500  -o1 -S -r64   -t4    /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8                                                                               
+ADS1036 aio-stress -I500  -o1 -S -r128  -t4    /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8                                                                               
+ADS1037 aio-stress -I500  -o1 -S -r256  -t8  /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file4  /test/aiodio/file3  /test/aiodio/file5  /test/aiodio/file6
+ADS1038 aio-stress -I500  -o1 -S -r512  -t8  -x /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
+ADS1039 aio-stress -I500  -o1 -O -r4    -t8  -x  /test/aiodio/junkfile /test/aiodio/file2        /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
+ADS1040 aio-stress -I500  -o1 -O -r8    -t2  -x /test/aiodio/junkfile /test/aiodio/file2         
+ADS1041 aio-stress -I500  -o1 -O -r16   -t2  -x  /test/aiodio/junkfile /test/aiodio/file2         
+ADS1042 aio-stress -I500  -o1 -O -r32   -t2   /test/aiodio/junkfile /test/aiodio/file2      
+ADS1043 aio-stress -I500  -o1 -O -r64   -t2   /test/aiodio/junkfile /test/aiodio/file2      
+ADS1044 aio-stress -I500  -o1 -O -r4    -t4   /test/aiodio/junkfile /test/aiodio/file2        /test/aiodio/file7  /test/aiodio/file8                                                                               
+ADS1045 aio-stress -I500  -o1 -O -r8    -t4   /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8                                                                               
+ADS1046 aio-stress -I500  -o1 -O -r16   -t4   /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8                                                                               
+ADS1047 aio-stress -I500  -o1 -O -r32   -t8   /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file4  /test/aiodio/file3  /test/aiodio/file5  /test/aiodio/file6
+ADS1048 aio-stress -I500  -o1 -O -r64   -t8   /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
+ADS1049 aio-stress -I500  -o1 -O -r128  -t8   /test/aiodio/junkfile /test/aiodio/file2        /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
+ADS1050 aio-stress -I500  -o1 -O -r256  -t2   /test/aiodio/junkfile /test/aiodio/file2                                                    
Index: ltp-full-20090430/runtest/ltp-aio-stress.part2
===================================================================
--- ltp-full-20090430.orig/runtest/ltp-aio-stress.part2
+++ ltp-full-20090430/runtest/ltp-aio-stress.part2
@@ -26,15 +26,15 @@
 #       -x turn off thread stonewalling
 #       -h this message
 #
-ADS001 aio-stress -I500  -o2 -S -r32  -t2  /test/aiodio/junkfile /test/aiodio2/file2
-ADS002 aio-stress -I500  -o3 -S -r8   -t2  /test/aiodio/junkfile /test/aiodio2/file2 
-ADS003 aio-stress -I500  -o3 -S -r16  -t2  /test/aiodio/junkfile /test/aiodio2/file2      
-ADS004 aio-stress -I500  -o3 -S -r32  -t4  /test/aiodio/junkfile /test/aiodio2/file2  /test/aiodio/file3  /test/aiodio2/file4       
-ADS005 aio-stress -I500  -o3 -S -r64  -t4  /test/aiodio/junkfile /test/aiodio2/file2  /test/aiodio/file3  /test/aiodio2/file4        
-ADS006 aio-stress -I500  -o2 -O -r32  -t2  /test/aiodio/junkfile /test/aiodio2/file2
-ADS007 aio-stress -I500  -o3 -O -r8   -t2  /test/aiodio/junkfile /test/aiodio2/file2 
-ADS008 aio-stress -I500  -o3 -O -r16  -t2  /test/aiodio/junkfile /test/aiodio2/file2      
-ADS009 aio-stress -I500  -o3 -O -r32  -t4  /test/aiodio/junkfile /test/aiodio2/file2  /test/aiodio/file3  /test/aiodio2/file4       
+ADS2001 aio-stress -I500  -o2 -S -r32  -t2  /test/aiodio/junkfile /test/aiodio2/file2
+ADS2002 aio-stress -I500  -o3 -S -r8   -t2  /test/aiodio/junkfile /test/aiodio2/file2 
+ADS2003 aio-stress -I500  -o3 -S -r16  -t2  /test/aiodio/junkfile /test/aiodio2/file2      
+ADS2004 aio-stress -I500  -o3 -S -r32  -t4  /test/aiodio/junkfile /test/aiodio2/file2  /test/aiodio/file3  /test/aiodio2/file4       
+ADS2005 aio-stress -I500  -o3 -S -r64  -t4  /test/aiodio/junkfile /test/aiodio2/file2  /test/aiodio/file3  /test/aiodio2/file4        
+ADS2006 aio-stress -I500  -o2 -O -r32  -t2  /test/aiodio/junkfile /test/aiodio2/file2
+ADS2007 aio-stress -I500  -o3 -O -r8   -t2  /test/aiodio/junkfile /test/aiodio2/file2 
+ADS2008 aio-stress -I500  -o3 -O -r16  -t2  /test/aiodio/junkfile /test/aiodio2/file2      
+ADS2009 aio-stress -I500  -o3 -O -r32  -t4  /test/aiodio/junkfile /test/aiodio2/file2  /test/aiodio/file3  /test/aiodio2/file4       
 ADS010 aio-stress -I500  -o3 -O -r64  -t4  /test/aiodio/junkfile /test/aiodio2/file2  /test/aiodio/file3  /test/aiodio2/file4        
                                                              
                                                              
Index: ltp-full-20090430/runtest/ltp-aiodio.part2
===================================================================
--- ltp-full-20090430.orig/runtest/ltp-aiodio.part2
+++ ltp-full-20090430/runtest/ltp-aiodio.part2
@@ -1,81 +1,81 @@
-ADS000 aiodio_sparse
-ADS001 aiodio_sparse -s 180k
-ADS002 aiodio_sparse -dd -s 1751k -r 18k -w 11k
-ADS003 aiodio_sparse -i 9 -d -s 180k -r 18k -w 18k
-ADS004 aiodio_sparse -i 2 -a 2k -r 2k -w 2k -s 4k -n 2
-ADS005 aiodio_sparse -i 2 -a 4k -r 4k -w 4k -s 8k -n 2
-ADS006 aiodio_sparse -i 2 -a 4k -r 4k -w 4k -s 8k -n 2
-ADS007 aiodio_sparse -i 4 -a 8k -r 8k -w 8k -s 32k -n 2
-ADS008 aiodio_sparse -i 4 -a 8k -r 8k -w 16k -s 64k -n 2
-ADS009 aiodio_sparse -i 4 -a 8k -r 8k -w 32k -s 128k -n 2
-ADS010 aiodio_sparse -i 4 -a 8k -r 8k -w 64k -s 256k -n 2
-ADS011 aiodio_sparse -i 4 -a 8k -r 8k -w 128k -s 512k -n 2
-ADS012 aiodio_sparse -i 4 -a 8k -r 8k -w 256k -s 1024k -n 2
-ADS013 aiodio_sparse -i 4 -a 8k -r 8k -w 512k -s 2048k -n 2
-ADS014 aiodio_sparse -i 4 -a 8k -r 8k -w 1024k -s 4096k -n 2
-ADS015 aiodio_sparse -i 4 -a 8k -r 8k -w 2048k -s 8192k -n 2
-ADS016 aiodio_sparse -i 4 -a 8k -r 8k -w 4096k -s 16384k -n 2
-ADS017 aiodio_sparse -i 4 -a 8k -r 8k -w 8192k -s 32768k -n 2
-ADS018 aiodio_sparse -i 4 -a 8k -r 8k -w 16384k -s 65536k -n 2
-ADS019 aiodio_sparse -i 4 -a 8k -r 8k -w 16384k -s 65536k -n 4
-ADS020 aiodio_sparse -i 4 -a 8k -r 8k -w 16384k -s 65536k -n 6
-ADS021 aiodio_sparse -i 4 -a 8k -r 16k -w 128k -s 512k -n 6
-ADS022 aiodio_sparse -i 4 -a 8k -r 16k -w 256k -s 1024k -n 6
-ADS023 aiodio_sparse -i 4 -a 8k -r 8k -w 512k -s 2048k -n 6
-ADS024 aiodio_sparse -i 4 -a 8k -r 8k -w 1024k -s 4096k -n 6
-ADS025 aiodio_sparse -i 4 -a 8k -r 32k -w 2048k -s 8192k -n 6
-ADS026 aiodio_sparse -i 4 -a 8k -r 32k -w 4096k -s 16384k -n 6
-ADS027 aiodio_sparse -i 4 -a 8k -r 8k -w 18192k -s 72768k -n 6
-ADS028 aiodio_sparse -i 4 -a 8k -r 8k -w 18192k -s 518192k -n 6
-ADS029 aiodio_sparse -i 4 -a 8k -r 64k -w 65536k -s 262144k -n 6
-ADS030 aiodio_sparse -i 6 -a 8k -r 8k -w 65536k -n 6 
-ADS031 aiodio_sparse -i 8 -a 8k -r 16k -w 128k -s 1024k -n 6
-ADS032 aiodio_sparse -i 16 -a 8k  -r 16k -w 256k -s 4096k -n 6
-ADS033 aiodio_sparse -i 32 -a 8k  -r 8k -w 512k -s 16384k -n 6
-ADS034 aiodio_sparse -i 64 -a 8k  -r 8k -w 1024k -s 65536k -n 6
-ADS035 aiodio_sparse -i 4 -a 8k  -r 32k -w 4096k -s 16384k -n 32
-ADS036 aiodio_sparse -i 4 -a 8k  -r 32k -w 4096k -s 16384k -n 64
-ADS037 aiodio_sparse -i 4 -a 8k  -r 8k -w 18192k -s 72768k -n 128
-ADS038 aiodio_sparse -i 4 -a 8k  -r 8k -w 18192k -n 512 
-ADS039 aiodio_sparse -i 4 -a 8k  -r 64k -w 18192k -n 1000
-ADS040 dio_sparse 
-ADS041 dio_sparse -s 180k
-ADS042 dio_sparse -dd -s 1751k -r 18k -w 11k
-ADS043 dio_sparse  -d -s 180k -r 18k -w 18k
-ADS044 dio_sparse  -a 2k -r 2k -w 2k -s 2k -n 2
-ADS045 dio_sparse  -a 4k -r 4k -w 4k -s 2k -n 2
-ADS046 dio_sparse  -a 4k -r 4k -w 4k -s 4k -n 2
-ADS047 dio_sparse  -a 8k -r 8k -w 16k -s 16k -n 2
-ADS048 dio_sparse  -a 8k -r 8k -w 32k -s 32k -n 2
-ADS049 dio_sparse  -a 8k -r 8k -w 64k -s 64k -n 2
-ADS050 dio_sparse  -a 8k -r 8k -w 128k -s 128k -n 2
-ADS051 dio_sparse  -a 8k -r 8k -w 256k -s 256k -n 2
-ADS052 dio_sparse  -a 8k -r 8k -w 512k -s 512k -n 2
-ADS053 dio_sparse  -a 8k -r 8k -w 1024k -s 1024k -n 2
-ADS054 dio_sparse  -a 8k -r 8k -w 2048k -s 2048k -n 2
-ADS055 dio_sparse  -a 8k -r 8k -w 4096k -s 4096k -n 2
-ADS056 dio_sparse  -a 8k -r 8k -w 8192k -s 8192k -n 2
-ADS057 dio_sparse  -a 8k -r 8k -w 18192k -s 18192k -n 2
-ADS058 dio_sparse  -a 8k -r 8k -w 518192k -s 518192k -n 2
-ADS059 dio_sparse  -a 8k -r 8k -w 58192k -s 58192k -n 4
-ADS060 dio_sparse  -a 8k -r 8k -w 58192k -s 58192k -n 6
-ADS061 dio_sparse  -a 8k -r 16k -w 256k -s 256k -n 6
-ADS062 dio_sparse  -a 8k -r 16k -w 512k -s 512k -n 6
-ADS063 dio_sparse  -a 8k -r 8k -w 1024k -s 1024k -n 6
-ADS064 dio_sparse  -a 8k -r 8k -w 2048k -s 2048k -n 6
-ADS065 dio_sparse  -a 8k -r 32k -w 2048k -s 4096k -n 6
-ADS066 dio_sparse  -a 8k -r 32k -w 8192k -s 8192k -n 6
-ADS067 dio_sparse  -a 8k -r 8k -w 18192k -s 18192k -n 6
-ADS068 dio_sparse  -a 8k -r 8k -w 58192k -s 518192k -n 6
-ADS069 dio_sparse  -a 8k -r 64k -w 58192k -s 58192k -n 6
-ADS070 dio_sparse  -a 8k -r 8k -w 518192k -s 518192k -n 6
-ADS071 dio_sparse  -a 8k -r 16k -w 256k -s 256k -n 6
-ADS072 dio_sparse  -a 8k -r 16k -w 512k -s 512k -n 6
-ADS073 dio_sparse  -a 8k -r 8k -w 1024k -s 1024k -n 6
-ADS074 dio_sparse  -a 8k -r 8k -w 1024k -s 2048k -n 6
-ADS075 dio_sparse  -a 8k -r 32k -w 4096k -s 4096k -n 32
-ADS076 dio_sparse  -a 8k -r 32k -w 8192k -s 8192k -n 64
-ADS077 dio_sparse  -a 8k -r 8k -w 518192k -s 18192k -n 128
-ADS078 dio_sparse  -a 8k -r 8k -w 518192k -s 518192k -n 512
-ADS079 dio_sparse  -a 8k -r 64k -w 518192k -s 518192k -n 1000
+ADSP000 aiodio_sparse
+ADSP001 aiodio_sparse -s 180k
+ADSP002 aiodio_sparse -dd -s 1751k -r 18k -w 11k
+ADSP003 aiodio_sparse -i 9 -d -s 180k -r 18k -w 18k
+ADSP004 aiodio_sparse -i 2 -a 2k -r 2k -w 2k -s 4k -n 2
+ADSP005 aiodio_sparse -i 2 -a 4k -r 4k -w 4k -s 8k -n 2
+ADSP006 aiodio_sparse -i 2 -a 4k -r 4k -w 4k -s 8k -n 2
+ADSP007 aiodio_sparse -i 4 -a 8k -r 8k -w 8k -s 32k -n 2
+ADSP008 aiodio_sparse -i 4 -a 8k -r 8k -w 16k -s 64k -n 2
+ADSP009 aiodio_sparse -i 4 -a 8k -r 8k -w 32k -s 128k -n 2
+ADSP010 aiodio_sparse -i 4 -a 8k -r 8k -w 64k -s 256k -n 2
+ADSP011 aiodio_sparse -i 4 -a 8k -r 8k -w 128k -s 512k -n 2
+ADSP012 aiodio_sparse -i 4 -a 8k -r 8k -w 256k -s 1024k -n 2
+ADSP013 aiodio_sparse -i 4 -a 8k -r 8k -w 512k -s 2048k -n 2
+ADSP014 aiodio_sparse -i 4 -a 8k -r 8k -w 1024k -s 4096k -n 2
+ADSP015 aiodio_sparse -i 4 -a 8k -r 8k -w 2048k -s 8192k -n 2
+ADSP016 aiodio_sparse -i 4 -a 8k -r 8k -w 4096k -s 16384k -n 2
+ADSP017 aiodio_sparse -i 4 -a 8k -r 8k -w 8192k -s 32768k -n 2
+ADSP018 aiodio_sparse -i 4 -a 8k -r 8k -w 16384k -s 65536k -n 2
+ADSP019 aiodio_sparse -i 4 -a 8k -r 8k -w 16384k -s 65536k -n 4
+ADSP020 aiodio_sparse -i 4 -a 8k -r 8k -w 16384k -s 65536k -n 6
+ADSP021 aiodio_sparse -i 4 -a 8k -r 16k -w 128k -s 512k -n 6
+ADSP022 aiodio_sparse -i 4 -a 8k -r 16k -w 256k -s 1024k -n 6
+ADSP023 aiodio_sparse -i 4 -a 8k -r 8k -w 512k -s 2048k -n 6
+ADSP024 aiodio_sparse -i 4 -a 8k -r 8k -w 1024k -s 4096k -n 6
+ADSP025 aiodio_sparse -i 4 -a 8k -r 32k -w 2048k -s 8192k -n 6
+ADSP026 aiodio_sparse -i 4 -a 8k -r 32k -w 4096k -s 16384k -n 6
+ADSP027 aiodio_sparse -i 4 -a 8k -r 8k -w 18192k -s 72768k -n 6
+ADSP028 aiodio_sparse -i 4 -a 8k -r 8k -w 18192k -s 518192k -n 6
+ADSP029 aiodio_sparse -i 4 -a 8k -r 64k -w 65536k -s 262144k -n 6
+ADSP030 aiodio_sparse -i 6 -a 8k -r 8k -w 65536k -n 6 
+ADSP031 aiodio_sparse -i 8 -a 8k -r 16k -w 128k -s 1024k -n 6
+ADSP032 aiodio_sparse -i 16 -a 8k  -r 16k -w 256k -s 4096k -n 6
+ADSP033 aiodio_sparse -i 32 -a 8k  -r 8k -w 512k -s 16384k -n 6
+ADSP034 aiodio_sparse -i 64 -a 8k  -r 8k -w 1024k -s 65536k -n 6
+ADSP035 aiodio_sparse -i 4 -a 8k  -r 32k -w 4096k -s 16384k -n 32
+ADSP036 aiodio_sparse -i 4 -a 8k  -r 32k -w 4096k -s 16384k -n 64
+ADSP037 aiodio_sparse -i 4 -a 8k  -r 8k -w 18192k -s 72768k -n 128
+ADSP038 aiodio_sparse -i 4 -a 8k  -r 8k -w 18192k -n 512 
+ADSP039 aiodio_sparse -i 4 -a 8k  -r 64k -w 18192k -n 1000
+ADSP040 dio_sparse 
+ADSP041 dio_sparse -s 180k
+ADSP042 dio_sparse -dd -s 1751k -r 18k -w 11k
+ADSP043 dio_sparse  -d -s 180k -r 18k -w 18k
+ADSP044 dio_sparse  -a 2k -r 2k -w 2k -s 2k -n 2
+ADSP045 dio_sparse  -a 4k -r 4k -w 4k -s 2k -n 2
+ADSP046 dio_sparse  -a 4k -r 4k -w 4k -s 4k -n 2
+ADSP047 dio_sparse  -a 8k -r 8k -w 16k -s 16k -n 2
+ADSP048 dio_sparse  -a 8k -r 8k -w 32k -s 32k -n 2
+ADSP049 dio_sparse  -a 8k -r 8k -w 64k -s 64k -n 2
+ADSP050 dio_sparse  -a 8k -r 8k -w 128k -s 128k -n 2
+ADSP051 dio_sparse  -a 8k -r 8k -w 256k -s 256k -n 2
+ADSP052 dio_sparse  -a 8k -r 8k -w 512k -s 512k -n 2
+ADSP053 dio_sparse  -a 8k -r 8k -w 1024k -s 1024k -n 2
+ADSP054 dio_sparse  -a 8k -r 8k -w 2048k -s 2048k -n 2
+ADSP055 dio_sparse  -a 8k -r 8k -w 4096k -s 4096k -n 2
+ADSP056 dio_sparse  -a 8k -r 8k -w 8192k -s 8192k -n 2
+ADSP057 dio_sparse  -a 8k -r 8k -w 18192k -s 18192k -n 2
+ADSP058 dio_sparse  -a 8k -r 8k -w 518192k -s 518192k -n 2
+ADSP059 dio_sparse  -a 8k -r 8k -w 58192k -s 58192k -n 4
+ADSP060 dio_sparse  -a 8k -r 8k -w 58192k -s 58192k -n 6
+ADSP061 dio_sparse  -a 8k -r 16k -w 256k -s 256k -n 6
+ADSP062 dio_sparse  -a 8k -r 16k -w 512k -s 512k -n 6
+ADSP063 dio_sparse  -a 8k -r 8k -w 1024k -s 1024k -n 6
+ADSP064 dio_sparse  -a 8k -r 8k -w 2048k -s 2048k -n 6
+ADSP065 dio_sparse  -a 8k -r 32k -w 2048k -s 4096k -n 6
+ADSP066 dio_sparse  -a 8k -r 32k -w 8192k -s 8192k -n 6
+ADSP067 dio_sparse  -a 8k -r 8k -w 18192k -s 18192k -n 6
+ADSP068 dio_sparse  -a 8k -r 8k -w 58192k -s 518192k -n 6
+ADSP069 dio_sparse  -a 8k -r 64k -w 58192k -s 58192k -n 6
+ADSP070 dio_sparse  -a 8k -r 8k -w 518192k -s 518192k -n 6
+ADSP071 dio_sparse  -a 8k -r 16k -w 256k -s 256k -n 6
+ADSP072 dio_sparse  -a 8k -r 16k -w 512k -s 512k -n 6
+ADSP073 dio_sparse  -a 8k -r 8k -w 1024k -s 1024k -n 6
+ADSP074 dio_sparse  -a 8k -r 8k -w 1024k -s 2048k -n 6
+ADSP075 dio_sparse  -a 8k -r 32k -w 4096k -s 4096k -n 32
+ADSP076 dio_sparse  -a 8k -r 32k -w 8192k -s 8192k -n 64
+ADSP077 dio_sparse  -a 8k -r 8k -w 518192k -s 18192k -n 128
+ADSP078 dio_sparse  -a 8k -r 8k -w 518192k -s 518192k -n 512
+ADSP079 dio_sparse  -a 8k -r 64k -w 518192k -s 518192k -n 1000
   

--huq684BweRXVnRxX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--huq684BweRXVnRxX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--huq684BweRXVnRxX--

