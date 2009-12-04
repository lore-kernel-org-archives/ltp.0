Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1NGYrc-0004IP-8D
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 14:10:28 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 2F4198672B
	for <ltp-list@lists.sourceforge.net>;
	Fri,  4 Dec 2009 15:10:12 +0100 (CET)
Date: Fri, 4 Dec 2009 15:11:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091204141109.GB27679@saboteur.suse.cz>
References: <20091105143910.GA18828@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20091105143910.GA18828@schrodinger.suse.cz>
Subject: Re: [LTP] [PATCH] rename coliding names in runtest files
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


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> Following patch renumbers testcase names in runtest/ltp-aio-stress.part1 and
> runtest/ltp-aio-stress.part2 so that their names don't collide. Also renames
> testcases in runtest/ltp-aiodio.part2 so that they don't collide with
> ltp-aio-stress ones.
> 

This patch fixes one overlooked line and also removes trailing whitespaces.

Signed-off-by: chrubis@suse.cz
 
-- 
Cyril Hrubis
chrubis@suse.cz

--+QahgC5+KEYLbs62
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="rename_testcases_II.patch"

Index: runtest/ltp-aio-stress.part1
===================================================================
--- runtest.orig/ltp-aio-stress.part1
+++ runtest/ltp-aio-stress.part1
@@ -26,41 +26,41 @@
 #       -x turn off thread stonewalling
 #       -h this message
 #
-ADS1000 aio-stress -I500  -o2 -S -r4   /test/aiodio/file1 
+ADS1000 aio-stress -I500  -o2 -S -r4   /test/aiodio/file1
 ADS1001 aio-stress -I500  -o2 -S -r8   /test/aiodio/file1
-ADS1002 aio-stress -I500  -o2 -S -r16  /test/aiodio/file1 
+ADS1002 aio-stress -I500  -o2 -S -r16  /test/aiodio/file1
 ADS1003 aio-stress -I500  -o2 -S -r32  -t2  /test/aiodio/junkfile /test/aiodio/file2
-ADS1004 aio-stress -I500  -o2 -S -r64   /test/aiodio/junkfile /test/aiodio/file2 
-ADS1005 aio-stress -I500  -o3 -S -r4    /test/aiodio/junkfile /test/aiodio/file2 
-ADS1006 aio-stress -I500  -o3 -S -r8   -t2  /test/aiodio/junkfile /test/aiodio/file2 
-ADS1007 aio-stress -I500  -o3 -S -r16  -t2  /test/aiodio/junkfile /test/aiodio/file2      
-ADS1008 aio-stress -I500  -o3 -S -r32  -t4  /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file3  /test/aiodio/file4       
-ADS1009 aio-stress -I500  -o3 -S -r64  -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4        
-ADS1010 aio-stress -I500  -o3 -S -r128 -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4    
+ADS1004 aio-stress -I500  -o2 -S -r64   /test/aiodio/junkfile /test/aiodio/file2
+ADS1005 aio-stress -I500  -o3 -S -r4    /test/aiodio/junkfile /test/aiodio/file2
+ADS1006 aio-stress -I500  -o3 -S -r8   -t2  /test/aiodio/junkfile /test/aiodio/file2
+ADS1007 aio-stress -I500  -o3 -S -r16  -t2  /test/aiodio/junkfile /test/aiodio/file2
+ADS1008 aio-stress -I500  -o3 -S -r32  -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4
+ADS1009 aio-stress -I500  -o3 -S -r64  -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4
+ADS1010 aio-stress -I500  -o3 -S -r128 -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4
 ADS1011 aio-stress -I500  -o3 -S -r256 -t8  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file3  /test/aiodio/file4 /test/aiodio/file5  /test/aiodio/file6 /test/aiodio/file7  /test/aiodio/file8
 ADS1012 aio-stress -I500  -o3 -S -r512 -t8  /test/aiodio/junkfile /test/aiodio/file2 /test/aiodio/file3  /test/aiodio/file4 /test/aiodio/file5  /test/aiodio/file6 /test/aiodio/file7  /test/aiodio/file8
 ADS1013 aio-stress -I500  -o2 -O -r4    -t8  /test/aiodio/junkfile /test/aiodio/file2 /test/aiodio/file3  /test/aiodio/file4 /test/aiodio/file5  /test/aiodio/file6 /test/aiodio/file7  /test/aiodio/file8
-ADS1014 aio-stress -I500  -o2 -O -r8         /test/aiodio/file1 /test/aiodio/file2            
-ADS1015 aio-stress -I500  -o2 -O -r16        /test/aiodio/file1 /test/aiodio/file2         
-ADS1016 aio-stress -I500  -o2 -O -r32   -t2  /test/aiodio/junkfile /test/aiodio/file2 
-ADS1017 aio-stress -I500  -o2 -O -r64   -t2  /test/aiodio/junkfile /test/aiodio/file2 
-ADS1018 aio-stress -I500  -o3 -O -r4    -t2  /test/aiodio/junkfile /test/aiodio/file2 
-ADS1019 aio-stress -I500  -o3 -O -r8    -t2  /test/aiodio/junkfile /test/aiodio/file2 
-ADS1020 aio-stress -I500  -o3 -O -r16   -t2  /test/aiodio/junkfile /test/aiodio/file2 
-ADS1021 aio-stress -I500  -o3 -O -r32   -t4  /test/aiodio/junkfile /test/aiodio/file2       /test/aiodio/file7  /test/aiodio/file8     
-ADS1022 aio-stress -I500  -o3 -O -r64   -t4  /test/aiodio/junkfile /test/aiodio/file2    /test/aiodio/file7  /test/aiodio/file8   
-ADS1023 aio-stress -I500  -o3 -O -r128  -t4  /test/aiodio/junkfile /test/aiodio/file2    /test/aiodio/file7  /test/aiodio/file8  
-ADS1024 aio-stress -I500  -o3 -O -r256  -t8  /test/aiodio/junkfile /test/aiodio/file2    /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file4  /test/aiodio/file3  /test/aiodio/file5  /test/aiodio/file6 
-ADS1025 aio-stress -I500  -o3 -O -r512  -t8  /test/aiodio/junkfile /test/aiodio/file2 /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6 
-ADS1026 aio-stress -I500  -o0 -S -r4    -t8  /test/aiodio/junkfile /test/aiodio/file2       /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6    
-ADS1027 aio-stress -I500  -o0 -S -r8           /test/aiodio/file2            
-ADS1028 aio-stress -I500  -o0 -S -r16          /test/aiodio/file2         
-ADS1029 aio-stress -I500  -o0 -S -r32   -t2    /test/aiodio/junkfile /test/aiodio/file2         
-ADS1030 aio-stress -I500  -o0 -S -r64   -t2    /test/aiodio/junkfile /test/aiodio/file2         
-ADS1031 aio-stress -I500  -o1 -S -r4    -t2    /test/aiodio/junkfile /test/aiodio/file2         
-ADS1032 aio-stress -I500  -o1 -S -r8    -t2    /test/aiodio/junkfile /test/aiodio/file2      
-ADS1033 aio-stress -I500  -o1 -S -r16   -t2    /test/aiodio/junkfile /test/aiodio/file2      
-ADS1034 aio-stress -I500  -o1 -S -r32   -t4    /test/aiodio/junkfile /test/aiodio/file2        /test/aiodio/file7  /test/aiodio/file8                                                                               
+ADS1014 aio-stress -I500  -o2 -O -r8         /test/aiodio/file1 /test/aiodio/file2
+ADS1015 aio-stress -I500  -o2 -O -r16        /test/aiodio/file1 /test/aiodio/file2
+ADS1016 aio-stress -I500  -o2 -O -r32   -t2  /test/aiodio/junkfile /test/aiodio/file2
+ADS1017 aio-stress -I500  -o2 -O -r64   -t2  /test/aiodio/junkfile /test/aiodio/file2
+ADS1018 aio-stress -I500  -o3 -O -r4    -t2  /test/aiodio/junkfile /test/aiodio/file2
+ADS1019 aio-stress -I500  -o3 -O -r8    -t2  /test/aiodio/junkfile /test/aiodio/file2
+ADS1020 aio-stress -I500  -o3 -O -r16   -t2  /test/aiodio/junkfile /test/aiodio/file2
+ADS1021 aio-stress -I500  -o3 -O -r32   -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8
+ADS1022 aio-stress -I500  -o3 -O -r64   -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8
+ADS1023 aio-stress -I500  -o3 -O -r128  -t4  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8
+ADS1024 aio-stress -I500  -o3 -O -r256  -t8  /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file4  /test/aiodio/file3  /test/aiodio/file5  /test/aiodio/file6
+ADS1025 aio-stress -I500  -o3 -O -r512  -t8  /test/aiodio/junkfile /test/aiodio/file2 /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
+ADS1026 aio-stress -I500  -o0 -S -r4    -t8  /test/aiodio/junkfile /test/aiodio/file2       /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
+ADS1027 aio-stress -I500  -o0 -S -r8           /test/aiodio/file2
+ADS1028 aio-stress -I500  -o0 -S -r16          /test/aiodio/file2
+ADS1029 aio-stress -I500  -o0 -S -r32   -t2    /test/aiodio/junkfile /test/aiodio/file2
+ADS1030 aio-stress -I500  -o0 -S -r64   -t2    /test/aiodio/junkfile /test/aiodio/file2
+ADS1031 aio-stress -I500  -o1 -S -r4    -t2    /test/aiodio/junkfile /test/aiodio/file2
+ADS1032 aio-stress -I500  -o1 -S -r8    -t2    /test/aiodio/junkfile /test/aiodio/file2
+ADS1033 aio-stress -I500  -o1 -S -r16   -t2    /test/aiodio/junkfile /test/aiodio/file2
+ADS1034 aio-stress -I500  -o1 -S -r32   -t4    /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8
 ADS1035 aio-stress -I500  -o1 -S -r64   -t4    /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8                                                                               
 ADS1036 aio-stress -I500  -o1 -S -r128  -t4    /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8                                                                               
 ADS1037 aio-stress -I500  -o1 -S -r256  -t8  /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file4  /test/aiodio/file3  /test/aiodio/file5  /test/aiodio/file6
@@ -76,4 +76,4 @@ ADS1046 aio-stress -I500  -o1 -O -r16   
 ADS1047 aio-stress -I500  -o1 -O -r32   -t8   /test/aiodio/junkfile /test/aiodio/file2     /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file4  /test/aiodio/file3  /test/aiodio/file5  /test/aiodio/file6
 ADS1048 aio-stress -I500  -o1 -O -r64   -t8   /test/aiodio/junkfile /test/aiodio/file2  /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
 ADS1049 aio-stress -I500  -o1 -O -r128  -t8   /test/aiodio/junkfile /test/aiodio/file2        /test/aiodio/file7  /test/aiodio/file8 /test/aiodio/file3  /test/aiodio/file4  /test/aiodio/file5  /test/aiodio/file6
-ADS1050 aio-stress -I500  -o1 -O -r256  -t2   /test/aiodio/junkfile /test/aiodio/file2                                                    
+ADS1050 aio-stress -I500  -o1 -O -r256  -t2   /test/aiodio/junkfile /test/aiodio/file2
Index: runtest/ltp-aio-stress.part2
===================================================================
--- runtest.orig/ltp-aio-stress.part2
+++ runtest/ltp-aio-stress.part2
@@ -27,16 +27,12 @@
 #       -h this message
 #
 ADS2001 aio-stress -I500  -o2 -S -r32  -t2  /test/aiodio/junkfile /test/aiodio2/file2
-ADS2002 aio-stress -I500  -o3 -S -r8   -t2  /test/aiodio/junkfile /test/aiodio2/file2 
-ADS2003 aio-stress -I500  -o3 -S -r16  -t2  /test/aiodio/junkfile /test/aiodio2/file2      
-ADS2004 aio-stress -I500  -o3 -S -r32  -t4  /test/aiodio/junkfile /test/aiodio2/file2  /test/aiodio/file3  /test/aiodio2/file4       
-ADS2005 aio-stress -I500  -o3 -S -r64  -t4  /test/aiodio/junkfile /test/aiodio2/file2  /test/aiodio/file3  /test/aiodio2/file4        
+ADS2002 aio-stress -I500  -o3 -S -r8   -t2  /test/aiodio/junkfile /test/aiodio2/file2
+ADS2003 aio-stress -I500  -o3 -S -r16  -t2  /test/aiodio/junkfile /test/aiodio2/file2
+ADS2004 aio-stress -I500  -o3 -S -r32  -t4  /test/aiodio/junkfile /test/aiodio2/file2 /test/aiodio/file3 /test/aiodio2/file4
+ADS2005 aio-stress -I500  -o3 -S -r64  -t4  /test/aiodio/junkfile /test/aiodio2/file2 /test/aiodio/file3 /test/aiodio2/file4
 ADS2006 aio-stress -I500  -o2 -O -r32  -t2  /test/aiodio/junkfile /test/aiodio2/file2
-ADS2007 aio-stress -I500  -o3 -O -r8   -t2  /test/aiodio/junkfile /test/aiodio2/file2 
-ADS2008 aio-stress -I500  -o3 -O -r16  -t2  /test/aiodio/junkfile /test/aiodio2/file2      
-ADS2009 aio-stress -I500  -o3 -O -r32  -t4  /test/aiodio/junkfile /test/aiodio2/file2  /test/aiodio/file3  /test/aiodio2/file4       
-ADS010 aio-stress -I500  -o3 -O -r64  -t4  /test/aiodio/junkfile /test/aiodio2/file2  /test/aiodio/file3  /test/aiodio2/file4        
-                                                             
-                                                             
-                                                             
-                                                             
+ADS2007 aio-stress -I500  -o3 -O -r8   -t2  /test/aiodio/junkfile /test/aiodio2/file2
+ADS2008 aio-stress -I500  -o3 -O -r16  -t2  /test/aiodio/junkfile /test/aiodio2/file2
+ADS2009 aio-stress -I500  -o3 -O -r32  -t4  /test/aiodio/junkfile /test/aiodio2/file2 /test/aiodio/file3 /test/aiodio2/file4
+ADS2010 aio-stress -I500  -o3 -O -r64  -t4  /test/aiodio/junkfile /test/aiodio2/file2 /test/aiodio/file3 /test/aiodio2/file4

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
--+QahgC5+KEYLbs62
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--+QahgC5+KEYLbs62--

