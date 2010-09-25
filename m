Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OzMod-0002IQ-4E
	for ltp-list@lists.sourceforge.net; Sat, 25 Sep 2010 04:56:51 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OzMoc-0005Tk-6i
	for ltp-list@lists.sourceforge.net; Sat, 25 Sep 2010 04:56:51 +0000
Received: by iwn2 with SMTP id 2so3778245iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 24 Sep 2010 21:56:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100924132104.GC7889@dhcp-27-139.brq.redhat.com>
References: <20100924130014.GB7889@dhcp-27-139.brq.redhat.com>
	<20100924132104.GC7889@dhcp-27-139.brq.redhat.com>
Date: Fri, 24 Sep 2010 21:56:44 -0700
Message-ID: <AANLkTin2=Hcf-FLqJ=1DFmQg1x+T1o84JH-LkAWXQcRK@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016e644df0a68073a04910e52b2
Subject: Re: [LTP] [PATCH] fix incorrect cleanup after hugeshmget05 test
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
To: Jan Tluka <jtluka@redhat.com>
Cc: ltp-list@lists.sourceforge.net

--0016e644df0a68073a04910e52b2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 24, 2010 at 6:21 AM, Jan Tluka <jtluka@redhat.com> wrote:
> Resending ...
>
> I've noticed that in some cases the hugeshmget05 testcase is not
> cleaning up properly after itself. It leaves hugepages reserved and
> does not free them. This could break further test runs.
>
> I think the problem is with signal handling. The testcase will do
> rm_shm() only if it ends up properly. In case it's being killed by
> SIGTERM signal (as seen from the testlog) the cleanup() function does
> not return shared memory.
>
> Without the patch I have to use ipcrm to remove all hugepages reserved
> and not returned.
>
> # grep -i unexpected RHEL-hugepage.run.log
> hugeshmget05 =A0 =A01 =A0TBROK =A0: =A0Unexpected signal 15 received.
> # ipcs -m
> ------ Shared Memory Segments --------
> key =A0 =A0 =A0 =A0shmid =A0 =A0 =A0owner =A0 =A0 =A0perms =A0 =A0 =A0byt=
es =A0 =A0 =A0nattch =A0 =A0 status
> 0x7400ee08 3932160 =A0 =A0root =A0 =A0 =A0600 =A0 =A0 =A0 =A04 =A0 =A0 =
=A0 =A0 =A00
> 0x7400edde 4620289 =A0 =A0root =A0 =A0 =A0600 =A0 =A0 =A0 =A04 =A0 =A0 =
=A0 =A0 =A00
> 0x00000000 4980738 =A0 =A0gdm =A0 =A0 =A0 600 =A0 =A0 =A0 =A0393216 =A0 =
=A0 2 =A0 =A0 =A0 =A0 =A0dest
> 0x7400eddd 4587523 =A0 =A0root =A0 =A0 =A0600 =A0 =A0 =A0 =A04 =A0 =A0 =
=A0 =A0 =A00
> 0x78002a3b 64552964 =A0 root =A0 =A0 =A0600 =A0 =A0 =A0 =A0209715200 =A00
> 0x78002a38 64520197 =A0 root =A0 =A0 =A0600 =A0 =A0 =A0 =A0209715200 =A00
> # ipcrm -m 64552964 -m 64520197
>
> With the patch the test returns hugepages back to the system even if it
> gets signal 15.
>
> Checked on RHEL5.5.
>
> Thanks, Jan
>
>
> The patch follows,
>
>
> --- ltp-full-20100831/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget0=
5.c =A0 =A02010-09-14 13:04:33.000000000 +0200
> +++ ltp-full-20100831.new/testcases/kernel/mem/hugetlb/hugeshmget/hugeshm=
get05.c =A0 =A0 =A0 =A02010-09-24 13:47:19.413177300 +0200
> @@ -105,7 +105,6 @@
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0do_child();
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cleanup();
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*NOTREACHED*/
> =A0 =A0 =A0 =A0} else { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* parent */
> @@ -114,11 +113,10 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_brkm(TBROK, cleanup, "=
waitpid failed");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* if it exists, remove the shared memory r=
esource */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 rm_shm(shm_id_1);
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Remove the temporary directory */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_rmdir();
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cleanup();
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -209,6 +207,9 @@
> =A0void
> =A0cleanup(void)
> =A0{
> + =A0 =A0 =A0 /* if it exists, remove the shared memory resource */
> + =A0 =A0 =A0 rm_shm(shm_id_1);
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * print timing stats if that option was specified.
> =A0 =A0 =A0 =A0 * print errno log if that option was specified.

Hi Jan,
    I spotted some other potential issues with the test. Please try
this patch and let me know whether or not it works for you .
Cheers,
-Garrett

--0016e644df0a68073a04910e52b2
Content-Type: text/x-patch; charset=US-ASCII;
	name="fix-rmshm-hugeshmget05.patch"
Content-Disposition: attachment; filename="fix-rmshm-hugeshmget05.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gei0c2db0

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobWdldC9odWdl
c2htZ2V0MDUuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobWdldC9odWdl
c2htZ2V0MDUuYwppbmRleCBiYzRiZDJjLi4zZTllMjZhIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMv
a2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1nZXQvaHVnZXNobWdldDA1LmMKKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htZ2V0L2h1Z2VzaG1nZXQwNS5jCkBAIC03Nyw3
ICs3Nyw4IEBAIGNoYXIgKmx0cF91c2VyID0gIm5vYm9keSI7CiBpbnQgbWFpbihpbnQgYWMsIGNo
YXIgKiphdikKIHsKIAljaGFyICptc2c7CQkJLyogbWVzc2FnZSByZXR1cm5lZCBmcm9tIHBhcnNl
X29wdHMgKi8KLQlpbnQgcGlkOworCXBpZF90IHBpZDsKKwlpbnQgc3RhdHVzOwogCXZvaWQgZG9f
Y2hpbGQodm9pZCk7CiAKIAkvKiBwYXJzZSBzdGFuZGFyZCBvcHRpb25zICovCkBAIC0xMDUsMjEg
KzEwNiwyMiBAQCBpbnQgbWFpbihpbnQgYWMsIGNoYXIgKiphdikKIAogCQlkb19jaGlsZCgpOwog
Ci0JCWNsZWFudXAoKTsKLQorCQl0c3RfZXhpdCgpOwogCQkvKk5PVFJFQUNIRUQqLwogCX0gZWxz
ZSB7CQkvKiBwYXJlbnQgKi8KIAkJLyogd2FpdCBmb3IgdGhlIGNoaWxkIHRvIHJldHVybiAqLwot
CQlpZiAod2FpdHBpZChwaWQsIE5VTEwsIDApID09IC0xKSB7Ci0JCQl0c3RfYnJrbShUQlJPSywg
Y2xlYW51cCwgIndhaXRwaWQgZmFpbGVkIik7CisJCWlmICh3YWl0cGlkKHBpZCwgJnN0YXR1cywg
MCkgPT0gLTEpIHsKKwkJCXRzdF9yZXNtKFRCUk9LLCAid2FpdHBpZCBmYWlsZWQiKTsKKwkJfQor
CQllbHNlIGlmIChzdGF0dXMgIT0gMCkgeworCQkJdHN0X3Jlc20oVEZBSUwsCSJjaGlsZCBwcm9j
ZXNzIGZhaWxlZCB0byBleGl0IGNsZWFubHkgIgorCQkJCSIoZXhpdCBzdGF0dXMgPSAlZCkiLCBz
dGF0dXMpOwogCQl9CisJfQogCi0JCS8qIGlmIGl0IGV4aXN0cywgcmVtb3ZlIHRoZSBzaGFyZWQg
bWVtb3J5IHJlc291cmNlICovCi0JCXJtX3NobShzaG1faWRfMSk7CisJY2xlYW51cCgpOwogCi0J
CS8qIFJlbW92ZSB0aGUgdGVtcG9yYXJ5IGRpcmVjdG9yeSAqLwotCQl0c3Rfcm1kaXIoKTsKLQl9
CisJLyogTk9UUkVBQ0hFRCAqLwogCXJldHVybiAwOwogfQogCkBAIC0xNTIsMTMgKzE1NCwxMSBA
QCBkb19jaGlsZCgpCiAKIAkJc3dpdGNoKFRFU1RfRVJSTk8pIHsKIAkJY2FzZSBFQUNDRVM6Ci0J
CQl0c3RfcmVzbShUUEFTUywgImV4cGVjdGVkIGZhaWx1cmUgLSBlcnJubyA9ICIKLQkJCQkgIiVk
IDogJXMiLCBURVNUX0VSUk5PLCBzdHJlcnJvcihURVNUX0VSUk5PKSk7CisJCQl0c3RfcmVzbShU
UEFTU3xUVEVSUk5PLCAiZXhwZWN0ZWQgZmFpbHVyZSIpOwogCQkJYnJlYWs7CiAJCWRlZmF1bHQ6
Ci0JCQl0c3RfcmVzbShURkFJTCwgImNhbGwgZmFpbGVkIHdpdGggYW4gIgotCQkJCSAidW5leHBl
Y3RlZCBlcnJvciAtICVkIDogJXMiLAotCQkJCSBURVNUX0VSUk5PLCBzdHJlcnJvcihURVNUX0VS
Uk5PKSk7CisJCQl0c3RfcmVzbShURkFJTHxUVEVSUk5PLCAiY2FsbCBmYWlsZWQgd2l0aCBhbiAi
CisJCQkJICJ1bmV4cGVjdGVkIGVycm9yIik7CiAJCQlicmVhazsKIAkJfQkJCiAJfQpAQCAtMjA5
LDYgKzIwOSw5IEBAIHNldHVwKHZvaWQpCiB2b2lkCiBjbGVhbnVwKHZvaWQpCiB7CisJLyogaWYg
aXQgZXhpc3RzLCByZW1vdmUgdGhlIHNoYXJlZCBtZW1vcnkgcmVzb3VyY2UgKi8KKwlybV9zaG0o
c2htX2lkXzEpOworCiAJLyoKIAkgKiBwcmludCB0aW1pbmcgc3RhdHMgaWYgdGhhdCBvcHRpb24g
d2FzIHNwZWNpZmllZC4KIAkgKiBwcmludCBlcnJubyBsb2cgaWYgdGhhdCBvcHRpb24gd2FzIHNw
ZWNpZmllZC4K
--0016e644df0a68073a04910e52b2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
--0016e644df0a68073a04910e52b2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016e644df0a68073a04910e52b2--

