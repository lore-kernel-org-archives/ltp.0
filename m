Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NVPSJ-0001Gb-Lt
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 13:09:43 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NVPSG-0002br-M9
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 13:09:43 +0000
Received: by pwj11 with SMTP id 11so4310457pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Jan 2010 05:09:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41001140029m64f5b903sae6c8d007f4f7822@mail.gmail.com>
References: <1713808934.618481261374276809.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<1964681948.618501261374329418.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<364299f40912210110m27ba4276g8cbce963d077e4a0@mail.gmail.com>
	<364299f40912211838w7ab92a76u50223c29588b6f1a@mail.gmail.com>
	<000901ca94eb$792f5150$6b8df3f0$@co.jp>
	<364299f41001140029m64f5b903sae6c8d007f4f7822@mail.gmail.com>
Date: Thu, 14 Jan 2010 04:41:48 -0800
Message-ID: <364299f41001140441v21608eb5t55f8ec9aab0ea4f0@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Thu, Jan 14, 2010 at 12:29 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Wed, Jan 13, 2010 at 11:30 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> Hi,
>>
>> I tried to test "unzip01".
>> But I get still the same fail at 2010-01-14 cvs.
>>
>> I think that this failure occurs because "DIR" can't be defined
>> correctly in "${LTPROOT}/testcases/commands/unzip/Makefile" and
>> all files of "/opt/ltp/testcases/bin" directory was compressed.
>>
>> There is the definition "DIR :=3D tst_unzip.dir" in "${LTPROOT}/testcases
>> /commands/unzip/Makefile". But there is the definition "DIR :=3D /opt/ltp
>> /testcases/bin" in two include files ("${LTPROOT}/include/mk/env_pre.mk"
>> and "${LTPROOT}/include/mk/generic_leaf_target.mk") which are included
>> in "${LTPROOT}/testcases/commands/unzip/Makefile".
>>
>> Perhaps, "DIR :=3D tst_unzip.dir" is replaced by "DIR :=3D /opt/ltp
>> /testcases/bin" when the two files were included, I think.
>>
>> This test requires "tst_unzip.dir" and if the variable name "DIR" is
>> changed to another name, this problem will not occur.
>>
>>
>>> .INTERMEDIATE may be the only piece of value here, but I was avoiding
>>> it because it's a 3.81-ism I thought...
>>
>> So, I don't try use .INTERMEDIATE target.
>>
>> However, the compress target directory ("tst_unzip.dir") is created
>> under "$LTPROOT/testcases/commands/unzip" directory.
>> But I think that it does not affect for the test because the compressed
>> file which is for the test ("tst_unzip_file.zip") is create under
>> the run directory ("/opy/ltp"). "tst_unzip.dir" is the file which isn't
>> related directly to the practice of the test, I think.
>>
>> How about this patch:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- Makefile.org =A0 =A0 =A0 =A02009-12-11 21:50:29.000000000 +0900
>> +++ Makefile =A0 =A02010-01-14 11:44:30.000000000 +0900
>> @@ -27,7 +27,7 @@
>> =A0# Only build and install if we have the zip command.
>> =A0HAVE_ZIPTOOLS =A0 =A0 =A0 =A0 =A0:=3D $(shell if which zip >/dev/null=
; then echo yes;
>> else echo no; fi)
>>
>> -DIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D tst_unzip.dir
>> +COMPRESS_DIR =A0 =A0 =A0 =A0 =A0 :=3D tst_unzip.dir
>>
>> =A0RM =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D -r
>>
>> @@ -36,7 +36,7 @@
>> =A0ZIPFILE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D $(TESTCAS=
ES_DATA_DIR)/tst_unzip_file.zip
>>
>> =A0ifeq ($(HAVE_ZIPTOOLS),yes)
>> -CLEAN_TARGETS =A0 =A0 =A0 =A0 =A0:=3D $(DIR) $(ZIPFILE)
>> +CLEAN_TARGETS =A0 =A0 =A0 =A0 =A0:=3D $(COMPRESS_DIR) $(ZIPFILE)
>> =A0INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D unzip_tests.sh
>> =A0endif
>>
>> @@ -45,13 +45,13 @@
>> =A0$(TESTCASES_DATA_DIR):
>> =A0 =A0 =A0 =A0mkdir -p "$@"
>>
>> -$(ZIPFILE): | $(TESTCASES_DATA_DIR) $(DIR)
>> - =A0 =A0 =A0 zip -r "$@" $(DIR)
>> +$(ZIPFILE): | $(TESTCASES_DATA_DIR) $(COMPRESS_DIR)
>> + =A0 =A0 =A0 zip -r "$@" $(COMPRESS_DIR)
>> =A0 =A0 =A0 =A0chmod 00666 "$@"
>>
>> =A0# This target should be auto-removed by Make
>> -$(DIR): $(abs_srcdir)/unzip_genfile.sh
>> - =A0 =A0 =A0 $(SHELL) "$^" $(DIR)
>> +$(COMPRESS_DIR): $(abs_srcdir)/unzip_genfile.sh
>> + =A0 =A0 =A0 $(SHELL) "$^" $(COMPRESS_DIR)
>>
>> =A0include $(top_srcdir)/include/mk/generic_leaf_target.mk
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>
>> I'm glad if I can get opinion that my revision is right or not.
>>
>>
>> Regards--
>>
>>
>> -Tomonori Mitani
>
> Crap, you spotted the problem, but it was just in the wrong spot (from
> functions.mk):
>
> #
> # Generate the directory install dependency separate from generate_instal=
l_rule
> # to avoid noise from Make about redefining existing targets, for good re=
ason.
> #
> # 1 -> The base install directory, based off $(prefix), or another
> # =A0 =A0 =A0$(prefix)-like variable. Automatically gets $(DESTDIR) tacke=
d on it.
> # 2 -> The install target. This can be relative to $(srcdir), but will mo=
st
> # =A0 =A0 =A0likely be `empty'.
> #
> define generate_install_rule_dir_dep
> ifdef MAKE_3_80_COMPAT
> DIR =A0 =A0 :=3D $$(call MAKE_3_80_abspath,$(DESTDIR)/$(1)/$(2))
> else
> DIR =A0 =A0 :=3D $$(abspath $(DESTDIR)/$(1)/$(2))
> endif
> $$(DIR):
> =A0 =A0 =A0 =A0mkdir -p "$$@"
> endef
>
>>_>... I'm trying out something to get rid of this item... I'll get back t=
o you in a few.
>
>> -----Original Message-----
>> From: Garrett Cooper [mailto:yanegomi@gmail.com]
>> Sent: Tuesday, December 22, 2009 11:39 AM
>> To: Caspar Zhang
>> Cc: ltp-list@lists.sourceforge.net; Mitani
>> Subject: Re: [LTP] "unzip01" testcase failed.
>>
>> On Mon, Dec 21, 2009 at 1:10 AM, Garrett Cooper <yanegomi@gmail.com> wro=
te:
>>> On Sun, Dec 20, 2009 at 9:45 PM, Caspar Zhang <czhang@redhat.com> wrote:
>>>>
>>>> ----- "Garrett Cooper" <yanegomi@gmail.com> wrote:
>>>>>
>>>>> I'm not convinced that this is the right solution because most of
>>>>> what's done here just replaced $(DIR)'s value with the bareword
>>>>> value.
>>>>> .INTERMEDIATE may be the only piece of value here, but I was avoiding
>>>>> it because it's a 3.81-ism I thought...
>>>>
>>>> How about this one (see the attachment)?
>>>
>>> AH... -[Rr] was missing.
>>>
>>> RM +=3D -[Rr]
>>>
>>> will do that. The rest just seems spurious.
>>
>> =A0 =A0Uh, this was already committed on HEAD:

    Please try now. I removed the other offending code in include/mk.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
