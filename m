Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PfThW-0006V2-QB
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:47:34 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PfThV-0004aX-Lp
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:47:34 +0000
Received: by wwi18 with SMTP id 18so586686wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 19 Jan 2011 00:47:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D369E98.4060602@cn.fujitsu.com>
References: <4D369E98.4060602@cn.fujitsu.com>
Date: Wed, 19 Jan 2011 00:47:27 -0800
Message-ID: <AANLkTi=z3=QTuMR5ofejRB=8A95WXHc8MKT-0+syVv-W@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cdfd8f8147e1a049a2f110c
Subject: Re: [LTP] [PATCH] fsync02: fix error of overflow from MUL
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

--000e0cdfd8f8147e1a049a2f110c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 19, 2011 at 12:19 AM, Peng Haitao <penght@cn.fujitsu.com> wrote=
:
> Hi Garrett,
>
> If the third argument is SEEK_SET of function fsync(), offset can not be
> negative. But when overflow from MUL, the offset is negative.
>
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>
>
> ---
> =A0testcases/kernel/syscalls/fsync/fsync02.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fsync/fsync02.c b/testcases/kernel=
/syscalls/fsync/fsync02.c
> index 213eac3..64bb012 100644
> --- a/testcases/kernel/syscalls/fsync/fsync02.c
> +++ b/testcases/kernel/syscalls/fsync/fsync02.c
> @@ -102,7 +102,7 @@ int main(int ac, char **av)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 1; i <=3D data_blocks; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D (i * BLOCKSIZE *=
 max_block) / data_blocks - BUFSIZ;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D (BLOCKSIZE * max=
_block) / data_blocks * i - BUFSIZ;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((offsetret =3D lseek(f=
d, offset, SEEK_SET)) !=3D offset)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_brkm(T=
BROK|TERRNO, cleanup, "lseek failed: %ld, %ld", offsetret, offset);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((ret =3D write(fd, pbu=
f, BUFSIZ)) !=3D BUFSIZ)
> @@ -197,4 +197,4 @@ void cleanup()
>
> =A0 =A0 =A0 =A0tst_rmdir();
>
> -}
> \ No newline at end of file
> +}
> --
> 1.7.3.1
>
> --
> Best Regards,
> Peng Haitao
>
>

    How about the following item?
    Please try the attached patch over the following -- it's just
there for review.
Thanks,
-Garrett

$ git diff testcases/kernel/syscalls/fsync/fsync02.c
diff --git a/testcases/kernel/syscalls/fsync/fsync02.c
b/testcases/kernel/syscalls/fsync/fsync02.c
index 213eac3..6227a84 100644
--- a/testcases/kernel/syscalls/fsync/fsync02.c
+++ b/testcases/kernel/syscalls/fsync/fsync02.c
@@ -102,7 +102,8 @@ int main(int ac, char **av)
                }

                for (i =3D 1; i <=3D data_blocks; i++) {
-                       offset =3D (i * BLOCKSIZE * max_block) /
data_blocks - BUFSIZ;
+                       offset =3D i * ((BLOCKSIZE * max_block) / data_bloc=
ks);
+                       offset -=3D BUFSIZ;
                        if ((offsetret =3D lseek(fd, offset, SEEK_SET)) !=
=3D offset)
                                tst_brkm(TBROK|TERRNO, cleanup, "lseek
failed: %ld, %ld", offsetret, offset);
                        if ((ret =3D write(fd, pbuf, BUFSIZ)) !=3D BUFSIZ)
@@ -197,4 +198,4 @@ void cleanup()

        tst_rmdir();

-}
\ No newline at end of file
+}

--000e0cdfd8f8147e1a049a2f110c
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Sort-multipliers-to-avoid-accidental-overflow.patch"
Content-Disposition: attachment; 
	filename="0001-Sort-multipliers-to-avoid-accidental-overflow.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gj3zo8090

RnJvbSAxYTE0NzhhNDE2MmNkZjI5NjYwNzcxMDE5MTE5ODdmZDIyMzAwYmRlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHYXJyZXR0IENvb3BlciA8eWFuZWdvbWlAZ21haWwuY29tPgpE
YXRlOiBXZWQsIDE5IEphbiAyMDExIDAwOjQyOjMxIC0wODAwClN1YmplY3Q6IFtQQVRDSF0gU29y
dCBtdWx0aXBsaWVycyB0byBhdm9pZCBhY2NpZGVudGFsIG92ZXJmbG93LgpNSU1FLVZlcnNpb246
IDEuMApDb250ZW50LVR5cGU6IG11bHRpcGFydC9taXhlZDsgYm91bmRhcnk9Ii0tLS0tLS0tLS0t
LTEuNy4zLjUiCgpUaGlzIGlzIGEgbXVsdGktcGFydCBtZXNzYWdlIGluIE1JTUUgZm9ybWF0Lgot
LS0tLS0tLS0tLS0tLTEuNy4zLjUKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVU
Ri04OyBmb3JtYXQ9Zml4ZWQKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoKClNpZ25l
ZC1vZmYtYnk6IFBlbmcgSGFpdGFvIDxwZW5naHRAY24uZnVqaXRzdS5jb20+ClNpZ25lZC1vZmYt
Ynk6IEdhcnJldHQgQ29vcGVyIDx5YW5lZ29taUBnbWFpbC5jb20+Ci0tLQogdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9mc3luYy9mc3luYzAyLmMgfCAgICA1ICsrKy0tCiAxIGZpbGVzIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCgotLS0tLS0tLS0tLS0tLTEuNy4z
LjUKQ29udGVudC1UeXBlOiB0ZXh0L3gtcGF0Y2g7IG5hbWU9IjAwMDEtU29ydC1tdWx0aXBsaWVy
cy10by1hdm9pZC1hY2NpZGVudGFsLW92ZXJmbG93LnBhdGNoIgpDb250ZW50LVRyYW5zZmVyLUVu
Y29kaW5nOiA4Yml0CkNvbnRlbnQtRGlzcG9zaXRpb246IGF0dGFjaG1lbnQ7IGZpbGVuYW1lPSIw
MDAxLVNvcnQtbXVsdGlwbGllcnMtdG8tYXZvaWQtYWNjaWRlbnRhbC1vdmVyZmxvdy5wYXRjaCIK
CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZzeW5jL2ZzeW5jMDIuYyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnN5bmMvZnN5bmMwMi5jCmluZGV4IDIxM2VhYzMu
LjYyMjdhODQgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnN5bmMvZnN5
bmMwMi5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnN5bmMvZnN5bmMwMi5jCkBA
IC0xMDIsNyArMTAyLDggQEAgaW50IG1haW4oaW50IGFjLCBjaGFyICoqYXYpCiAJCX0KIAogCQlm
b3IgKGkgPSAxOyBpIDw9IGRhdGFfYmxvY2tzOyBpKyspIHsKLQkJCW9mZnNldCA9IChpICogQkxP
Q0tTSVpFICogbWF4X2Jsb2NrKSAvIGRhdGFfYmxvY2tzIC0gQlVGU0laOworCQkJb2Zmc2V0ID0g
aSAqICgoQkxPQ0tTSVpFICogbWF4X2Jsb2NrKSAvIGRhdGFfYmxvY2tzKTsKKwkJCW9mZnNldCAt
PSBCVUZTSVo7CiAJCQlpZiAoKG9mZnNldHJldCA9IGxzZWVrKGZkLCBvZmZzZXQsIFNFRUtfU0VU
KSkgIT0gb2Zmc2V0KQogCQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgImxzZWVr
IGZhaWxlZDogJWxkLCAlbGQiLCBvZmZzZXRyZXQsIG9mZnNldCk7CiAJCQlpZiAoKHJldCA9IHdy
aXRlKGZkLCBwYnVmLCBCVUZTSVopKSAhPSBCVUZTSVopCkBAIC0xOTcsNCArMTk4LDQgQEAgdm9p
ZCBjbGVhbnVwKCkKIAogCXRzdF9ybWRpcigpOwogCi19ClwgTm8gbmV3bGluZSBhdCBlbmQgb2Yg
ZmlsZQorfQoKLS0tLS0tLS0tLS0tLS0xLjcuMy41LS0KCgo=
--000e0cdfd8f8147e1a049a2f110c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
--000e0cdfd8f8147e1a049a2f110c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cdfd8f8147e1a049a2f110c--

