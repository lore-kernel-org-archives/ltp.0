Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PpLuC-0005jy-0L
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 14:29:28 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PpLuA-0001pw-Sg
	for ltp-list@lists.sourceforge.net; Tue, 15 Feb 2011 14:29:27 +0000
Received: by wyb40 with SMTP id 40so205373wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 15 Feb 2011 06:29:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D5A47E5.3060108@cn.fujitsu.com>
References: <4D5A47E5.3060108@cn.fujitsu.com>
Date: Tue, 15 Feb 2011 06:29:20 -0800
Message-ID: <AANLkTikjFEnngX7__W7gK8UBTV8O50vf-My5unK_P=8p@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=000e0ce0ad1e7a4c3f049c52fd9c
Subject: Re: [LTP] [PATCH] unshare01.c: TEST_RETURN is used wrong
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

--000e0ce0ad1e7a4c3f049c52fd9c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 15, 2011 at 1:31 AM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
> ---
> =A0testcases/kernel/syscalls/unshare/unshare01.c | =A0 =A06 +++---
> =A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/unshare/unshare01.c b/testcases/ke=
rnel/syscalls/unshare/unshare01.c
> index e19d73d..9ae5e8f 100644
> --- a/testcases/kernel/syscalls/unshare/unshare01.c
> +++ b/testcases/kernel/syscalls/unshare/unshare01.c
> @@ -206,7 +206,7 @@ int main(int ac, char **av) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pid1 =3D fork();
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (TEST_RETURN =3D=3D -1) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pid1 =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_brkm(T=
FAIL|TERRNO, cleanup,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"f=
ork failed");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else if (pid1 =3D=3D 0) =
{
> @@ -249,7 +249,7 @@ int main(int ac, char **av) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pid1 =3D=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_brkm(T=
FAIL|TERRNO, cleanup,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"f=
ork() failed.");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (TEST_RETURN =3D=
=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (pid1 =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TEST(unsha=
re(CLONE_NEWNS));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (TEST_R=
ETURN =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0printf("unshare call with CLONE_NEWNS "
> @@ -299,4 +299,4 @@ int main(void)
> =A0 =A0 =A0 =A0tst_resm(TCONF, "unshare is undefined.");
> =A0 =A0 =A0 =A0tst_exit();
> =A0}
> -#endif
> \ No newline at end of file
> +#endif

How about this?
Thanks,
-Garrett

--000e0ce0ad1e7a4c3f049c52fd9c
Content-Type: text/x-patch; charset=US-ASCII; 
	name="ltp-testcases-kernel-syscalls-unshare-fix.patch"
Content-Disposition: attachment; 
	filename="ltp-testcases-kernel-syscalls-unshare-fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gk6wrpnh0

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFyZS91bnNoYXJlMDEu
YyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFyZS91bnNoYXJlMDEuYwppbmRleCBl
MTlkNzNkLi5hNDYwMjQ4IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Vu
c2hhcmUvdW5zaGFyZTAxLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bnNoYXJl
L3Vuc2hhcmUwMS5jCkBAIC0xMDksMTQgKzEwOSwxNCBAQCBpbnQgIFRTVF9UT1RBTCA9IDE7CQkg
ICAvKiB0b3RhbCBudW1iZXIgb2YgdGVzdHMgaW4gdGhpcyBmaWxlLiAgICovCiAvKiBEZXNjcmlw
dGlvbjogUGVyZm9ybXMgYWxsIG9uZSB0aW1lIGNsZWFuIHVwIGZvciB0aGlzIHRlc3Qgb24gc3Vj
Y2Vzc2Z1bCAgICAqLwogLyoJICAgICAgY29tcGxldGlvbiwgIHByZW1hdHVyZSBleGl0IG9yICBm
YWlsdXJlLiBDbG9zZXMgYWxsIHRlbXBvcmFyeSAqLwogLyoJICAgICAgZmlsZXMsIHJlbW92ZXMg
YWxsIHRlbXBvcmFyeSBkaXJlY3RvcmllcyBleGl0cyB0aGUgdGVzdCB3aXRoICAqLwotLyoJICAg
ICAgYXBwcm9wcmlhdGUgVEVTVF9SRVRVUk51cm4gY29kZSBieSBjYWxsaW5nIHRzdF9leGl0KCkg
ZnVuY3Rpb24uICAgICAgICovCisvKgkgICAgICBhcHByb3ByaWF0ZSByZXR1cm4gY29kZSBieSBj
YWxsaW5nIHRzdF9leGl0KCkgZnVuY3Rpb24uICAgICAgICovCiAvKgkJCQkJCQkJCSAgICAqLwog
LyogSW5wdXQ6ICAgICAgIE5vbmUuCQkJCQkJCSAqLwogLyoJCQkJCQkJCQkgICAgKi8KIC8qIE91
dHB1dDogICAgICBOb25lLgkJCQkJCQkgKi8KIC8qCQkJCQkJCQkJICAgICovCi0vKiBSZXR1cm46
ICAgICAgT24gZmFpbHVyZSAtIEV4aXRzIGNhbGxpbmcgdHN0X2V4aXQoKS4gTm9uICcwJyBURVNU
X1JFVFVSTnVybiBjb2RlLiAgICovCi0vKgkgICAgICBPbiBzdWNjZXNzIC0gRXhpdHMgY2FsbGlu
ZyB0c3RfZXhpdCgpLiBXaXRoICcwJyBURVNUX1JFVFVSTnVybiBjb2RlLiAgKi8KKy8qIFJldHVy
bjogICAgICBPbiBmYWlsdXJlIC0gRXhpdHMgY2FsbGluZyB0c3RfZXhpdCgpLiBOb24gJzAnIHJl
dHVybiBjb2RlLiAgICovCisvKgkgICAgICBPbiBzdWNjZXNzIC0gRXhpdHMgY2FsbGluZyB0c3Rf
ZXhpdCgpLiBXaXRoICcwJyByZXR1cm4gY29kZS4gICovCiAvKgkJCQkJCQkJCSAgICAqLwogLyoq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKi8KIGV4dGVybiB2b2lkIGNsZWFudXAoKSB7CkBAIC0xNDAsNyAr
MTQwLDcgQEAgZXh0ZXJuIHZvaWQgY2xlYW51cCgpIHsKIC8qIE91dHB1dDogICAgICBOb25lLgkJ
CQkJCQkgKi8KIC8qCQkJCQkJCQkJICAgICovCiAvKiBSZXR1cm46ICAgICAgT24gZmFpbHVyZSAt
IEV4aXRzIGJ5IGNhbGxpbmcgY2xlYW51cCgpLgkJICAgICAgKi8KLS8qCSAgICAgIE9uIHN1Y2Nl
c3MgLSBURVNUX1JFVFVSTnVybnMgMC4JCQkJICAgICAgICovCisvKgkgICAgICBPbiBzdWNjZXNz
IC0gcmV0dXJucyAwLgkJCQkgICAgICAgKi8KIC8qCQkJCQkJCQkJICAgICovCiAvKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqLwogdm9pZCBzZXR1cCgpIHsKQEAgLTE1NCw3ICsxNTQsNyBAQCBpbnQgbWFp
bihpbnQgYWMsIGNoYXIgKiphdikgewogCXBpZF90IHBpZDE7CiAJaW50IGxjOwkJCS8qIGxvb3Ag
Y291bnRlciAqLwogCWludCBydmFsOwotCWNoYXIgKm1zZzsJCS8qIG1lc3NhZ2UgVEVTVF9SRVRV
Uk51cm5lZCBmcm9tIHBhcnNlX29wdHMgKi8KKwljaGFyICptc2c7CQkvKiBtZXNzYWdlIHJldHVy
bmVkIGZyb20gcGFyc2Vfb3B0cyAqLwogCiAJLyogcGFyc2Ugc3RhbmRhcmQgb3B0aW9ucyAqLwog
CWlmICgobXNnID0gcGFyc2Vfb3B0cyhhYywgYXYsIE5VTEwsIE5VTEwpKSAhPSBOVUxMKQpAQCAt
MTY2LDIwICsxNjYsMjAgQEAgaW50IG1haW4oaW50IGFjLCBjaGFyICoqYXYpIHsKIAkJVHN0X2Nv
dW50ID0gMDsKIAkJZm9yICh0ZXN0bm8gPSAwOyB0ZXN0bm8gPCBUU1RfVE9UQUw7ICsrdGVzdG5v
KSB7CiAKLQkJCVRFU1QocGlkMSA9IGZvcmsoKSk7ICAgIC8vY2FsbCB0byBmb3JrKCkKLQkJCWlm
IChURVNUX1JFVFVSTiA9PSAtMSkgewotCQkJCXRzdF9icmttKFRGQUlMfFRURVJSTk8sIGNsZWFu
dXAsICJmb3JrIGZhaWxlZCIpOwotCQkJfSBlbHNlIGlmIChURVNUX1JFVFVSTiA9PSAwKSB7Ci0J
CQkJVEVTVCh1bnNoYXJlKENMT05FX0ZJTEVTKSk7Ci0JCQkJaWYgKFRFU1RfUkVUVVJOID09IDAp
IHsKKwkJCXBpZDEgPSBmb3JrKCk7ICAgIC8vY2FsbCB0byBmb3JrKCkKKwkJCWlmIChwaWQxID09
IC0xKSB7CisJCQkJdHN0X2Jya20oVEZBSUx8VEVSUk5PLCBjbGVhbnVwLCAiZm9yayBmYWlsZWQi
KTsKKwkJCX0gZWxzZSBpZiAocGlkMSA9PSAwKSB7CisJCQkJc3dpdGNoICh1bnNoYXJlKENMT05F
X0ZJTEVTKSkgeworCQkJCWNhc2UgMDoKIAkJCQkJcHJpbnRmKCJ1bnNoYXJlIHdpdGggQ0xPTkVf
RklMRVMgY2FsbCAiCiAJCQkJCSAgICAic3VjY2VlZGVkXG4iKTsKIAkJCQkJcnZhbCA9IDA7Ci0J
CQkJfSBlbHNlIGlmIChURVNUX1JFVFVSTiA9PSAtMSkgewotCQkJCQlpZiAoVEVTVF9FUlJOTyA9
PSBFTk9TWVMpIHsKKwkJCQkJYnJlYWs7CisJCQkJY2FzZSAtMToKKwkJCQkJaWYgKGVycm5vID09
IEVOT1NZUykKIAkJCQkJCXJ2YWwgPSAxOwotCQkJCQl9IGVsc2UgewotCQkJCQkJZXJybm8gPSBU
RVNUX0VSUk5POworCQkJCQllbHNlIHsKIAkJCQkJCXBlcnJvcigidW5zaGFyZSBmYWlsZWQiKTsK
IAkJCQkJCXJ2YWwgPSAyOwogCQkJCQl9CkBAIC0yMDAsMzYgKzIwMCwzNCBAQCBpbnQgbWFpbihp
bnQgYWMsIGNoYXIgKiphdikgewogCQkJCQlkZWZhdWx0OgogCQkJCQkJdHN0X2Jya20oVEZBSUws
IGNsZWFudXAsCiAJCQkJCQkgICAgInVuc2hhcmUgZmFpbGVkIik7Ci0JCQkJCQlicmVhazsKIAkJ
CQkJfQogCQkJCX0KIAkJCX0KIAogCQkJcGlkMSA9IGZvcmsoKTsKLQkJCWlmIChURVNUX1JFVFVS
TiA9PSAtMSkgeworCQkJaWYgKHBpZDEgPT0gLTEpIHsKIAkJCQl0c3RfYnJrbShURkFJTHxURVJS
Tk8sIGNsZWFudXAsCiAJCQkJICAgICJmb3JrIGZhaWxlZCIpOwogCQkJfSBlbHNlIGlmIChwaWQx
ID09IDApIHsKLQkJCQlURVNUKHVuc2hhcmUoQ0xPTkVfRlMpKTsKLQkJCQlpZiAoVEVTVF9SRVRV
Uk4gPT0gMCkgeworCQkJCXN3aXRjaCAodW5zaGFyZShDTE9ORV9GUykpIHsKKwkJCQljYXNlIDA6
CiAJCQkJCXByaW50ZigidW5zaGFyZSB3aXRoIENMT05FX0ZTIGNhbGwgIgogCQkJCQkgICAgInN1
Y2NlZWRlZFxuIik7CiAJCQkJCXJ2YWwgPSAwOwotCQkJCX0gZWxzZSBpZiAoVEVTVF9SRVRVUk4g
PT0gLTEpIHsKLQkJCQkJaWYgKFRFU1RfRVJSTk8gPT0gRU5PU1lTKSB7CisJCQkJCWJyZWFrOwor
CQkJCWNhc2UgLTE6CisJCQkJCWlmIChlcnJubyA9PSBFTk9TWVMpCiAJCQkJCQlydmFsID0gMTsK
LQkJCQkJfSBlbHNlIHsKLQkJCQkJCWVycm5vID0gVEVTVF9FUlJOTzsKKwkJCQkJZWxzZSB7CiAJ
CQkJCQlwZXJyb3IoInVuc2hhcmUgZmFpbGVkIik7CiAJCQkJCQlydmFsID0gMjsKIAkJCQkJfQog
CQkJCX0KIAkJCQlleGl0KHJ2YWwpOwogCQkJfSBlbHNlIHsKLQkJCQlpZiAod2FpdCgmcnZhbCkg
PT0gLTEpIHsKKwkJCQlpZiAod2FpdCgmcnZhbCkgPT0gLTEpCiAJCQkJCXRzdF9icmttKFRCUk9L
fFRFUlJOTywgY2xlYW51cCwKIAkJCQkJICAgICJ3YWl0IGZhaWxlZCIpOwotCQkJCX0KIAkJCQlp
ZiAocnZhbCAhPSAwICYmIFdJRkVYSVRFRChydmFsKSkgewogCQkJCQlzd2l0Y2ggKFdFWElUU1RB
VFVTKHJ2YWwpKSB7CiAJCQkJCWNhc2UgMToKQEAgLTI0OSwxNyArMjQ3LDE3IEBAIGludCBtYWlu
KGludCBhYywgY2hhciAqKmF2KSB7CiAJCQlpZiAocGlkMSA9PSAtMSkgewogCQkJCXRzdF9icmtt
KFRGQUlMfFRFUlJOTywgY2xlYW51cCwKIAkJCQkgICAgImZvcmsoKSBmYWlsZWQuIik7Ci0JCQl9
IGVsc2UgaWYgKFRFU1RfUkVUVVJOID09IDApIHsKLQkJCQlURVNUKHVuc2hhcmUoQ0xPTkVfTkVX
TlMpKTsKLQkJCQlpZiAoVEVTVF9SRVRVUk4gPT0gMCkgeworCQkJfSBlbHNlIGlmIChwaWQxID09
IDApIHsKKwkJCQlzd2l0Y2ggKHVuc2hhcmUoQ0xPTkVfTkVXTlMpKSB7CisJCQkJY2FzZSAwOgog
CQkJCQlwcmludGYoInVuc2hhcmUgY2FsbCB3aXRoIENMT05FX05FV05TICIKIAkJCQkJICAgICJz
dWNjZWVkZWRcbiIpOwogCQkJCQlydmFsID0gMDsKLQkJCQl9IGVsc2UgaWYgKFRFU1RfUkVUVVJO
ID09IC0xKSB7Ci0JCQkJCWlmIChURVNUX0VSUk5PID09IEVOT1NZUykgeworCQkJCQlicmVhazsK
KwkJCQljYXNlIC0xOgorCQkJCQlpZiAoZXJybm8gPT0gRU5PU1lTKQogCQkJCQkJcnZhbCA9IDE7
Ci0JCQkJCX0gZWxzZSB7Ci0JCQkJCQllcnJubyA9IFRFU1RfRVJSTk87CisJCQkJCWVsc2Ugewog
CQkJCQkJcGVycm9yKCJ1bnNoYXJlIGZhaWxlZCIpOwogCQkJCQkJcnZhbCA9IDI7CiAJCQkJCX0K
QEAgLTI5OSw0ICsyOTcsNCBAQCBpbnQgbWFpbih2b2lkKQogCXRzdF9yZXNtKFRDT05GLCAidW5z
aGFyZSBpcyB1bmRlZmluZWQuIik7CiAJdHN0X2V4aXQoKTsKIH0KLSNlbmRpZgpcIE5vIG5ld2xp
bmUgYXQgZW5kIG9mIGZpbGUKKyNlbmRpZgo=
--000e0ce0ad1e7a4c3f049c52fd9c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
--000e0ce0ad1e7a4c3f049c52fd9c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0ce0ad1e7a4c3f049c52fd9c--

