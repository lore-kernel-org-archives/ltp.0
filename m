Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1OFAun-0001p5-AC
	for ltp-list@lists.sourceforge.net; Thu, 20 May 2010 18:56:17 +0000
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 3B14286A2E
	for <ltp-list@lists.sourceforge.net>;
	Thu, 20 May 2010 20:56:10 +0200 (CEST)
Date: Thu, 20 May 2010 21:05:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100520190559.GB15427@saboteur.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
Subject: [LTP] [PATCH] missing return in non void function
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


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Following patch adds "return NULL;" to the function returning void* in math
float tests. This change silences compiler warnings.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--oC1+HKm2/end4ao3
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="fix_return_type_math_float.patch"

Index: ltp-full-20100430/testcases/misc/math/float/main.c
===================================================================
--- ltp-full-20100430.orig/testcases/misc/math/float/main.c
+++ ltp-full-20100430/testcases/misc/math/float/main.c
@@ -393,7 +393,9 @@ static void *handle_signals (void *arg)
 		default:
 			exit (-1);
 		}
-	}while (TRUE);
+	} while (TRUE);
+
+	return NULL;
 }
 /*---------------------------------------------------------------------+
 |                               error ()                               |

--oC1+HKm2/end4ao3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--oC1+HKm2/end4ao3--

