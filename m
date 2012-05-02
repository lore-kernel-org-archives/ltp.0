Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SPan1-0004uS-2l
	for ltp-list@lists.sourceforge.net; Wed, 02 May 2012 14:44:23 +0000
Date: Wed, 2 May 2012 16:42:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120502144228.GF366@saboteur.suse.cz>
References: <0F68B52D2432864190BC72F760407FE93254CA39D1@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0F68B52D2432864190BC72F760407FE93254CA39D1@NDA-HCLT-EVS04.HCLT.CORP.HCL.IN>
Subject: Re: [LTP] Porting of LTP on Android - Patch
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Anupam Srivastava - ERS, HCL Tech" <Anupam_Srivastava@hcl.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> We have ported LTP open source (Version: ltp-full-20110228) on Android
> 2.2 Froyo. It will validate the reliability, robustness, and stability
> of Android. We want to submit the same to open source community.  PFA
> patch for the same. Please let me know if I have to do anything else
> regarding submission of this patch.

First of all, you should use lastest LTP in order to aviod collisions.
The best fit for development would be a git checkout and please use
unified diff format (diff -u) from now on.


diff -crB ltp-full-20110228//Android.mk ltp//Android.mk
*** ltp-full-20110228//Android.mk	2011-04-26 03:28:58.000000000 -0400
--- ltp//Android.mk	2011-06-10 07:11:04.000000000 -0400
***************
*** 10,16 ****
  export LTP_SCRIPTS_DIR := $(LTP_ROOT_DIR)/scripts
  export LTP_TESTCASES_DIR := $(LTP_ROOT_DIR)/testcases
  
! 
  
  subdirs := \
  	external/ltp/lib/Android.mk \
--- 10,16 ----
  export LTP_SCRIPTS_DIR := $(LTP_ROOT_DIR)/scripts
  export LTP_TESTCASES_DIR := $(LTP_ROOT_DIR)/testcases
  
! LOCAL_CFLAGS := -D_ANDROID
  
  subdirs := \
  	external/ltp/lib/Android.mk \

Hmm, that seems to be incomplete, we don't have Android.mk in our
sources.

diff -crB ltp-full-20110228//include/ltp_signal.h ltp//include/ltp_signal.h
*** ltp-full-20110228//include/ltp_signal.h	2011-06-09 05:00:49.000000000 -0400
--- ltp//include/ltp_signal.h	2011-08-02 07:11:21.000000000 -0400
***************
*** 23,28 ****
--- 23,30 ----
   *
   * Author: Liu Bo <liubo2009@cn.fujitsu.com>
   * Author: Garrett Cooper <yanegomi@gmail.com>
+  * 08/01/11 - Updated: Anupam Srivastava, anupam_srivastava@hcl.com
+  *			   - Config.h is not supported by Android
   *
   */

Please don't write dates and comments here. We use git to track this
informations. If you have changed a file just add simple line with your
name there.

Also the diff shows only change in the commend, is it incomplete too?

diff -crB ltp-full-20110228//include/tlibio.h ltp//include/tlibio.h
*** ltp-full-20110228//include/tlibio.h	2011-06-09 05:01:54.000000000 -0400
--- ltp//include/tlibio.h	2011-08-02 07:12:37.000000000 -0400
***************
*** 28,33 ****
--- 28,35 ----
   * For further information regarding this notice, see:
   *
   * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
+  * 08/01/11 - Updated: Anupam Srivastava, anupam_srivastava@hcl.com
+  *			   - aio.h is not supported by Android
   */
  
  #define LIO_IO_SYNC             00001   /* read/write */

The same problem as well.


... snip ...


diff -crB ltp-full-20110228//testcases/kernel/connectors/Android.mk ltp//testcases/kernel/connectors/Android.mk
*** ltp-full-20110228//testcases/kernel/connectors/Android.mk	2011-06-29 00:58:03.000000000 -0400
--- ltp//testcases/kernel/connectors/Android.mk	2011-06-29 01:37:34.000000000 -0400
***************
*** 1,19 ****
! ifneq ($(TARGET_SIMULATOR),true)
! LOCAL_PATH:= $(call my-dir)
! 
! include $(CLEAR_VARS)
! 
! subdirs := \
! 	external/ltp/testcases/kernel/pec/Android.mk
! 
! LOCAL_C_INCLUDES += $(LOCAL_PATH)
! LOCAL_C_INCLUDES += include
! 

This file has windows line ends, remove them.


The rest of the patch, if I understand it correctly mostly removes
subdirectories, which is simply wrong. There should be something similar
to ifeq(UCLINUX,1) to skip these tests.

You should also split the patch in several smaller so that each of them
changes one thing at a time.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
