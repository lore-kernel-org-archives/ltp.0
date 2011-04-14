Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1QANYy-0005KR-1r
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 14:30:28 +0000
Received: from mail-px0-f174.google.com ([209.85.212.174])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1QANYx-0002MU-6u
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 14:30:28 +0000
Received: by pxi15 with SMTP id 15so1399935pxi.33
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Apr 2011 07:30:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OF7FE76060.EAACC2A8-ON85257872.004D62BE-85257872.004ECF6E@us.ibm.com>
References: <OFCEFD64D0.BC49FB71-ON8525785E.0065EB2E-8525785E.0066D6A1@LocalDomain>
	<OF7FE76060.EAACC2A8-ON85257872.004D62BE-85257872.004ECF6E@us.ibm.com>
Date: Thu, 14 Apr 2011 07:30:21 -0700
Message-ID: <BANLkTim9UOO3bCubw+G+Px0-cV6vVuxsNQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=bcaec5430786e01ec504a0e1c33a
Subject: Re: [LTP] ioctl01.c bug in error message
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
To: Scott Romanowski <romansc@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

--bcaec5430786e01ec504a0e1c33a
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Apr 14, 2011 at 7:20 AM, Scott Romanowski <romansc@us.ibm.com> wrote:
> testcases/kernel/syscalls/ioctl/ioctl01.c has a bug where, if the open()
> fails, the error message it prints uses an uninitialized char * variable
> instead of the one that holds the device. This only affects the error
> message. The solution is to use 'devname' instead of 'tty' in the
> tst_brkm(), and you can also delete the unused variable, 'char *tty;'.

    tty is initialized -- just not the value that you want (0 because
it's in the BSS).
    Please try this patch and let me know how things go.
Thanks,
-Garrett

--bcaec5430786e01ec504a0e1c33a
Content-Type: text/x-patch; charset=US-ASCII; name="fix-ioctl01.patch"
Content-Disposition: attachment; filename="fix-ioctl01.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmhscv621

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaW9jdGwvaW9jdGwwMS5jIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bDAxLmMKaW5kZXggZThhMzVkYi4u
NDIyODQwNiAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0
bDAxLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bDAxLmMKQEAg
LTQ5LDExICs0OSwxMSBAQAogICogICAgICB0ZXN0IG1heSBoYXZlIHRvIGJlIHJ1biBhcyByb290
IGRlcGVuZGluZyBvbiB0aGUgdHR5IHBlcm1pc3Npb25zCiAgKi8KIAotI2luY2x1ZGUgPHN0ZGlv
Lmg+Ci0jaW5jbHVkZSA8c3lzL3Rlcm1pb3MuaD4KLSNpbmNsdWRlIDx0ZXJtaW8uaD4KICNpbmNs
dWRlIDxlcnJuby5oPgogI2luY2x1ZGUgPGZjbnRsLmg+CisjaW5jbHVkZSA8c3RkaW8uaD4KKyNp
bmNsdWRlIDx0ZXJtaW8uaD4KKyNpbmNsdWRlIDx0ZXJtaW9zLmg+CiAjaW5jbHVkZSAidGVzdC5o
IgogI2luY2x1ZGUgInVzY3Rlc3QuaCIKIApAQCAtNzEsNyArNzEsNiBAQCBpbnQgZXhwX2Vub3Nb
XSA9IHsgRUJBREYsIEVGQVVMVCwgRUlOVkFMLCBFTk9UVFksIEVGQVVMVCwgMCB9OwogaW50IGZk
LCBmZDE7CiBpbnQgYmZkID0gLTE7CiAKLWNoYXIgKnR0eTsKIHN0cnVjdCB0ZXJtaW8gdGVybWlv
OwogCiBzdHJ1Y3QgdGVzdF9jYXNlX3QgewpAQCAtMTIzLDEwICsxMjIsOCBAQCBpbnQgbWFpbihp
bnQgYWMsIGNoYXIgKiphdikKIAogCXNldHVwKCk7CiAKLQlpZiAoKGZkID0gb3BlbihkZXZuYW1l
LCBPX1JEV1IsIDA3NzcpKSA8IDApIHsKLQkJdHN0X2Jya20oVEJST0ssIGNsZWFudXAsICJDb3Vs
ZG4ndCBvcGVuICVzLCBlcnJubyA9ICVkIiwKLQkJCSB0dHksIGVycm5vKTsKLQl9CisJaWYgKChm
ZCA9IG9wZW4oZGV2bmFtZSwgT19SRFdSLCAwNzc3KSkgPT0gLTEpCisJCXRzdF9icmttKFRCUk9L
fFRFUlJOTywgY2xlYW51cCwgIkNvdWxkbid0IG9wZW4gJXMiLCBkZXZuYW1lKTsKIAogCVRFU1Rf
RVhQX0VOT1MoZXhwX2Vub3MpOwogCkBAIC0xNDYsMTUgKzE0MywxMiBAQCBpbnQgbWFpbihpbnQg
YWMsIGNoYXIgKiphdikKIAogCQkJVEVTVF9FUlJPUl9MT0coVEVTVF9FUlJOTyk7CiAKLQkJCWlm
IChURVNUX0VSUk5PID09IFRDW2ldLmVycm9yKSB7Ci0JCQkJdHN0X3Jlc20oVFBBU1MsICJleHBl
Y3RlZCBmYWlsdXJlIC0gIgotCQkJCQkgImVycm5vID0gJWQgOiAlcyIsIFRFU1RfRVJSTk8sCi0J
CQkJCSBzdHJlcnJvcihURVNUX0VSUk5PKSk7Ci0JCQl9IGVsc2UgewotCQkJCXRzdF9yZXNtKFRG
QUlMLCAidW5leHBlY3RlZCBlcnJvciAtICVkIDogJXMgLSAiCi0JCQkJCSAiZXhwZWN0ZWQgJWQi
LCBURVNUX0VSUk5PLAotCQkJCQkgc3RyZXJyb3IoVEVTVF9FUlJOTyksIFRDW2ldLmVycm9yKTsK
LQkJCX0KKwkJCWlmIChURVNUX0VSUk5PID09IFRDW2ldLmVycm9yKQorCQkJCXRzdF9yZXNtKFRQ
QVNTfFRURVJSTk8sICJmYWlsZWQgYXMgZXhwZWN0ZWQiKTsKKwkJCWVsc2UKKwkJCQl0c3RfcmVz
bShURkFJTHxUVEVSUk5PLAorCQkJCSAgICAiZmFpbGVkIHVuZXhwZWN0ZWRseTsgZXhwZWN0ZWQg
JWQgLSAlcyIsCisJCQkJICAgIFRDW2ldLmVycm9yLCBzdHJlcnJvcihUQ1tpXS5lcnJvcikpOwog
CQl9CiAJfQogCWNsZWFudXAoKTsKQEAgLTE2OCwxNCArMTYyLDE0IEBAIGludCBtYWluKGludCBh
YywgY2hhciAqKmF2KQogICovCiB2b2lkIGhlbHAoKQogeworCiAJcHJpbnRmKCIgIC1EIDx0dHkg
ZGV2aWNlPiA6IGZvciBleGFtcGxlLCAvZGV2L3R0eVswLTldXG4iKTsKIH0KIAogLyoKICAqIHNl
dHVwKCkgLSBwZXJmb3JtcyBhbGwgT05FIFRJTUUgc2V0dXAgZm9yIHRoaXMgdGVzdC4KICAqLwot
dm9pZCBzZXR1cCgpCi17Cit2b2lkIHNldHVwKHZvaWQpIHsKIAogCXRzdF9zaWcoTk9GT1JLLCBE
RUZfSEFORExFUiwgY2xlYW51cCk7CiAKQEAgLTE4NSwxNyArMTc5LDE2IEBAIHZvaWQgc2V0dXAo
KQogCXRzdF90bXBkaXIoKTsKIAogCS8qIGNyZWF0ZSBhIHRlbXBvcmFyeSBmaWxlICovCi0JaWYg
KChmZDEgPSBvcGVuKCJ4IiwgT19DUkVBVCwgMDc3NykpIDwgMCkgewotCQl0c3RfcmVzbShURkFJ
TCwgIkNvdWxkIG5vdCBvcGVuIHRlc3QgZmlsZSwgZXJybm8gPSAlZCIsIGVycm5vKTsKLQl9CisJ
aWYgKChmZDEgPSBvcGVuKCJ4IiwgT19DUkVBVCwgMDc3NykpID09IC0xKQorCQl0c3RfcmVzbShU
RkFJTHxURVJSTk8sICJDb3VsZCBub3Qgb3BlbiB0ZXN0IGZpbGUiKTsKIH0KIAogLyoKICAqIGNs
ZWFudXAoKSAtIHBlcmZvcm1zIGFsbCBPTkUgVElNRSBjbGVhbnVwIGZvciB0aGlzIHRlc3QgYXQK
ICAqCSAgICAgICBjb21wbGV0aW9uIG9yIHByZW1hdHVyZSBleGl0LgogICovCi12b2lkIGNsZWFu
dXAoKQotewordm9pZCBjbGVhbnVwKHZvaWQpIHsKKwogCS8qCiAJICogcHJpbnQgdGltaW5nIHN0
YXRzIGlmIHRoYXQgb3B0aW9uIHdhcyBzcGVjaWZpZWQuCiAJICogcHJpbnQgZXJybm8gbG9nIGlm
IHRoYXQgb3B0aW9uIHdhcyBzcGVjaWZpZWQuCkBAIC0yMDYsNSArMTk5LDQgQEAgdm9pZCBjbGVh
bnVwKCkKIAogCS8qIGRlbGV0ZSB0aGUgdGVzdCBkaXJlY3RvcnkgY3JlYXRlZCBpbiBzZXR1cCgp
ICovCiAJdHN0X3JtZGlyKCk7Ci0KLX0KXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlCit9Cg==
--bcaec5430786e01ec504a0e1c33a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
--bcaec5430786e01ec504a0e1c33a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--bcaec5430786e01ec504a0e1c33a--

