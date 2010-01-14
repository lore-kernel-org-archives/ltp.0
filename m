Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NVKAU-0005Lq-PA
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 07:30:58 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NVKAS-0002yo-9s
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 07:30:58 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <1713808934.618481261374276809.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>	
	<1964681948.618501261374329418.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>	
	<364299f40912210110m27ba4276g8cbce963d077e4a0@mail.gmail.com>
	<364299f40912211838w7ab92a76u50223c29588b6f1a@mail.gmail.com>
In-Reply-To: <364299f40912211838w7ab92a76u50223c29588b6f1a@mail.gmail.com>
Date: Thu, 14 Jan 2010 16:30:40 +0900
Message-ID: <000901ca94eb$792f5150$6b8df3f0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] "unzip01" testcase failed.
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
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

I tried to test "unzip01".
But I get still the same fail at 2010-01-14 cvs.

I think that this failure occurs because "DIR" can't be defined 
correctly in "${LTPROOT}/testcases/commands/unzip/Makefile" and 
all files of "/opt/ltp/testcases/bin" directory was compressed.

There is the definition "DIR := tst_unzip.dir" in "${LTPROOT}/testcases
/commands/unzip/Makefile". But there is the definition "DIR := /opt/ltp
/testcases/bin" in two include files ("${LTPROOT}/include/mk/env_pre.mk"
and "${LTPROOT}/include/mk/generic_leaf_target.mk") which are included 
in "${LTPROOT}/testcases/commands/unzip/Makefile".

Perhaps, "DIR := tst_unzip.dir" is replaced by "DIR := /opt/ltp
/testcases/bin" when the two files were included, I think.

This test requires "tst_unzip.dir" and if the variable name "DIR" is
changed to another name, this problem will not occur.


> .INTERMEDIATE may be the only piece of value here, but I was avoiding
> it because it's a 3.81-ism I thought...

So, I don't try use .INTERMEDIATE target.

However, the compress target directory ("tst_unzip.dir") is created
under "$LTPROOT/testcases/commands/unzip" directory.
But I think that it does not affect for the test because the compressed
file which is for the test ("tst_unzip_file.zip") is create under 
the run directory ("/opy/ltp"). "tst_unzip.dir" is the file which isn't
related directly to the practice of the test, I think.

How about this patch:
============
--- Makefile.org	2009-12-11 21:50:29.000000000 +0900
+++ Makefile	2010-01-14 11:44:30.000000000 +0900
@@ -27,7 +27,7 @@
 # Only build and install if we have the zip command.
 HAVE_ZIPTOOLS		:= $(shell if which zip >/dev/null; then echo yes;
else echo no; fi)
 
-DIR			:= tst_unzip.dir
+COMPRESS_DIR		:= tst_unzip.dir
 
 RM			+= -r
 
@@ -36,7 +36,7 @@
 ZIPFILE			:= $(TESTCASES_DATA_DIR)/tst_unzip_file.zip
 
 ifeq ($(HAVE_ZIPTOOLS),yes)
-CLEAN_TARGETS		:= $(DIR) $(ZIPFILE)
+CLEAN_TARGETS		:= $(COMPRESS_DIR) $(ZIPFILE)
 INSTALL_TARGETS		:= unzip_tests.sh
 endif
 
@@ -45,13 +45,13 @@
 $(TESTCASES_DATA_DIR):
 	mkdir -p "$@"
 
-$(ZIPFILE): | $(TESTCASES_DATA_DIR) $(DIR)
-	zip -r "$@" $(DIR)
+$(ZIPFILE): | $(TESTCASES_DATA_DIR) $(COMPRESS_DIR)
+	zip -r "$@" $(COMPRESS_DIR)
 	chmod 00666 "$@"
 
 # This target should be auto-removed by Make
-$(DIR): $(abs_srcdir)/unzip_genfile.sh
-	$(SHELL) "$^" $(DIR)
+$(COMPRESS_DIR): $(abs_srcdir)/unzip_genfile.sh
+	$(SHELL) "$^" $(COMPRESS_DIR)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
============


I'm glad if I can get opinion that my revision is right or not.


Regards--


-Tomonori Mitani


-----Original Message-----
From: Garrett Cooper [mailto:yanegomi@gmail.com] 
Sent: Tuesday, December 22, 2009 11:39 AM
To: Caspar Zhang
Cc: ltp-list@lists.sourceforge.net; Mitani
Subject: Re: [LTP] "unzip01" testcase failed.

On Mon, Dec 21, 2009 at 1:10 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Sun, Dec 20, 2009 at 9:45 PM, Caspar Zhang <czhang@redhat.com> wrote:
>>
>> ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
>>>
>>> I'm not convinced that this is the right solution because most of
>>> what's done here just replaced $(DIR)'s value with the bareword
>>> value.
>>> .INTERMEDIATE may be the only piece of value here, but I was avoiding
>>> it because it's a 3.81-ism I thought...
>>
>> How about this one (see the attachment)?
>
> AH... -[Rr] was missing.
>
> RM += -[Rr]
>
> will do that. The rest just seems spurious.

    Uh, this was already committed on HEAD:

http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/testcases/commands/unzip/Makef
ile?r1=1.9&r2=1.8

    What version are you working with?
Thanks,
-Garrett



------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
