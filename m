Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Otc1F-0001A4-CD
	for ltp-list@lists.sourceforge.net; Thu, 09 Sep 2010 07:58:05 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Otc1E-0004wu-89
	for ltp-list@lists.sourceforge.net; Thu, 09 Sep 2010 07:58:05 +0000
Received: by bwz12 with SMTP id 12so1202702bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Sep 2010 00:57:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C888C40.1040406@bull.net>
References: <4C888C40.1040406@bull.net>
Date: Thu, 9 Sep 2010 00:57:58 -0700
Message-ID: <AANLkTinTfZ9xOQSSs=bcnyhyucJR4jbmkyWeGNYy=k0W@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=001636c5a4100d9c84048fcefd2e
Subject: Re: [LTP] ltp-aiodio.part1 scenario FAIL with "No such file or
	directory", 
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
To: "Jacky.Malcles" <Jacky.Malcles@bull.net>
Cc: ltp-list@lists.sourceforge.net

--001636c5a4100d9c84048fcefd2e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 9, 2010 at 12:26 AM, Jacky.Malcles <Jacky.Malcles@bull.net> wro=
te:
> Hi Garet,
>
> ltp-aiodio.part1 scenario FAIL with "No such file or directory",
>
> i.e:
> [root@xena5 ltp]# tail -f ltpaiodio1.logfile
> AD138 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FAIL =A0 =A0 =A0=
 1
> AD044 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FAIL =A0 =A0 =A0=
 1
>
> -----------------------------------------------
> Total Tests: 214
> Total Failures: 214
>
> (it does not find the datas : =A0PIDs pb,)
> detail:
> <<<test_start>>>
> tag=3DAD209 stime=3D1283955400
> cmdline=3D"time aiocp -b 512k -n 32 -f SYNC $TMPDIR/aiodio.$$/junkfile
> $TMPDIR/aiodio.$$/ff2"
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
> /aiodio.12206/junkfile: No such file or directory
>
> real =A0 =A00m0.011s
> user =A0 =A00m0.000s
> sys =A0 =A0 0m0.000s
> <<<execution_status>>>
> initiation_status=3D"ok"
> duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
> so,
>
> I suggest, if you agree, the attached change to the scenario,

    Or the test tools could be fixed to honor $TMP (the best solution
would be to implement a -f option, but this is the quick and dirty
solution... a proper solution could come later).
Thanks,
-Garrett

--001636c5a4100d9c84048fcefd2e
Content-Type: application/octet-stream; name="fix-ltp-aiodio.diff"
Content-Disposition: attachment; filename="fix-ltp-aiodio.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gdvboqau1

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9haW9kaW9fc3BhcnNl
LmMgYi90ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vYWlvZGlvX3NwYXJzZS5jCmluZGV4
IGMzOGUwOGQuLmE2MDk5ODcgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFp
b2Rpby9haW9kaW9fc3BhcnNlLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlv
L2Fpb2Rpb19zcGFyc2UuYwpAQCAtMzYsNiArMzYsNyBAQAogI2luY2x1ZGUgPHVuaXN0ZC5oPgog
I2luY2x1ZGUgPHN5cy9tbWFuLmg+CiAjaW5jbHVkZSA8c3lzL3dhaXQuaD4KKyNpbmNsdWRlIDxs
aW1pdHMuaD4KIAogI2luY2x1ZGUgPGxpYmFpby5oPgogCkBAIC0zOTMsMTAgKzM5NCwxMCBAQCBs
b25nIGxvbmcgc2NhbGVfYnlfa21nKGxvbmcgbG9uZyB2YWx1ZSwgY2hhciBzY2FsZSkKIAogaW50
IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogeworCWNoYXIgZmlsZW5hbWVbUEFUSF9NQVhd
OwogCWludCBwaWRbTlVNX0NISUxEUkVOXTsKIAlpbnQgbnVtX2NoaWxkcmVuID0gMTsKIAlpbnQg
aTsKLQljaGFyICpmaWxlbmFtZSA9ICIvdGVzdC9haW9kaW8vZmlsZSI7CiAJbG9uZyBhbGlnbm1l
bnQgPSA1MTI7CiAJaW50IHJlYWRzaXplID0gNjU1MzY7CiAJaW50IHdyaXRlc2l6ZSA9IDY1NTM2
OwpAQCAtNDA3LDggKzQwOCwxMCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJ
ZXh0ZXJuIGNoYXIgKm9wdGFyZzsKIAlleHRlcm4gaW50IG9wdGluZCwgb3B0b3B0LCBvcHRlcnI7
CiAKLSAgICBwcmludGYoIkJlZ2luIGFpb2Rpb19zcGFyc2UgdGVzdHMuLi5cbiIpOworCXByaW50
ZigiQmVnaW4gYWlvZGlvX3NwYXJzZSB0ZXN0cy4uLlxuIik7CiAKKwlzbnByaW50ZihmaWxlbmFt
ZSwgc2l6ZW9mKGZpbGVuYW1lKSwgIiVzL2Fpb2Rpby9maWxlIiwKKwkJZ2V0ZW52KCJUTVAiKSA/
IGdldGVudigiVE1QIikgOiAiL3RtcCIpOwogCiAJd2hpbGUgKChjID0gZ2V0b3B0KGFyZ2MsIGFy
Z3YsICJkcjp3Om46YTpzOmk6IikpICE9IC0xKSB7CiAJCWNoYXIgKmVuZHA7CmRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vZGlvX2FwcGVuZC5jIGIvdGVzdGNhc2Vz
L2tlcm5lbC9pby9sdHAtYWlvZGlvL2Rpb19hcHBlbmQuYwppbmRleCAxZWM4YTg0Li43NWFjMWEz
IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vZGlvX2FwcGVuZC5j
CisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9kaW9fYXBwZW5kLmMKQEAgLTM5
LDYgKzM5LDcgQEAKICNpbmNsdWRlIDxzdGRpby5oPgogI2luY2x1ZGUgPHVuaXN0ZC5oPgogI2lu
Y2x1ZGUgPG1lbW9yeS5oPgorI2luY2x1ZGUgPGxpbWl0cy5oPgogI2RlZmluZSBOVU1fQ0hJTERS
RU4gOAogCiAKQEAgLTEyMywxMiArMTI0LDE1IEBAIHZvaWQgZGlvX2FwcGVuZChjaGFyICpmaWxl
bmFtZSkKIAogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogeworCWNoYXIgZmlsZW5h
bWVbUEFUSF9NQVhdOwogCWludCBwaWRbTlVNX0NISUxEUkVOXTsKIAlpbnQgbnVtX2NoaWxkcmVu
ID0gMTsKIAlpbnQgaTsKLQljaGFyICpmaWxlbmFtZSA9ICIvdGVzdC9haW9kaW8vZmlsZSI7CiAK
LSAgICBwcmludGYoIkJlZ2luIGRpb19hcHBlbmQgdGVzdC4uLlxuIik7CisJc25wcmludGYoZmls
ZW5hbWUsIHNpemVvZihmaWxlbmFtZSksICIlcy9haW9kaW8vZmlsZSIsCisJCWdldGVudigiVE1Q
IikgPyBnZXRlbnYoIlRNUCIpIDogIi90bXAiKTsKKworCXByaW50ZigiQmVnaW4gZGlvX2FwcGVu
ZCB0ZXN0Li4uXG4iKTsKIAogCWZvciAoaSA9IDA7IGkgPCBudW1fY2hpbGRyZW47IGkrKykgewog
CQlpZiAoKHBpZFtpXSA9IGZvcmsoKSkgPT0gMCkgewpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tl
cm5lbC9pby9sdHAtYWlvZGlvL2Rpb19zcGFyc2UuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRw
LWFpb2Rpby9kaW9fc3BhcnNlLmMKaW5kZXggMTc1NGIwNC4uYWFlNTNhZiAxMDA2NDQKLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Rpb19zcGFyc2UuYworKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL2lvL2x0cC1haW9kaW8vZGlvX3NwYXJzZS5jCkBAIC0zNiw2ICszNiw3IEBACiAj
aW5jbHVkZSA8bWVtb3J5Lmg+CiAjaW5jbHVkZSA8c3lzL21tYW4uaD4KICNpbmNsdWRlIDxzeXMv
d2FpdC5oPgorI2luY2x1ZGUgPGxpbWl0cy5oPgogCiAjaW5jbHVkZSAidGVzdC5oIgogCkBAIC0y
NzksMTAgKzI4MCwxMCBAQCBsb25nIGxvbmcgc2NhbGVfYnlfa21nKGxvbmcgbG9uZyB2YWx1ZSwg
Y2hhciBzY2FsZSkKIAogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQogeworCWNoYXIg
ZmlsZW5hbWVbUEFUSF9NQVhdOwogCWludCBwaWRbTlVNX0NISUxEUkVOXTsKIAlpbnQgbnVtX2No
aWxkcmVuID0gMTsKIAlpbnQgaTsKLQljaGFyICpmaWxlbmFtZSA9ICIvdGVzdC9haW9kaW8vZmls
ZSI7CiAJbG9uZyBhbGlnbm1lbnQgPSA1MTI7CiAJaW50IHJlYWRzaXplID0gNjU1MzY7CiAJaW50
IHdyaXRlc2l6ZSA9IDY1NTM2OwpAQCAtMjkyLDYgKzI5Myw5IEBAIGludCBtYWluKGludCBhcmdj
LCBjaGFyICoqYXJndikKIAlleHRlcm4gY2hhciAqb3B0YXJnOwogCWV4dGVybiBpbnQgb3B0aW5k
LCBvcHRvcHQsIG9wdGVycjsKIAorCXNucHJpbnRmKGZpbGVuYW1lLCBzaXplb2YoZmlsZW5hbWUp
LCAiJXMvYWlvZGlvL2ZpbGUiLAorCQlnZXRlbnYoIlRNUCIpID8gZ2V0ZW52KCJUTVAiKSA6ICIv
dG1wIik7CisKIAl3aGlsZSAoKGMgPSBnZXRvcHQoYXJnYywgYXJndiwgImRyOnc6bjphOnM6Iikp
ICE9IC0xKSB7CiAJCWNoYXIgKmVuZHA7CiAJCXN3aXRjaCAoYykgewpkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2Rpb190cnVuY2F0ZS5jIGIvdGVzdGNhc2VzL2tl
cm5lbC9pby9sdHAtYWlvZGlvL2Rpb190cnVuY2F0ZS5jCmluZGV4IGNiYTNiMTEuLjM3MzYzZWEg
MTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFpb2Rpby9kaW9fdHJ1bmNhdGUu
YworKysgYi90ZXN0Y2FzZXMva2VybmVsL2lvL2x0cC1haW9kaW8vZGlvX3RydW5jYXRlLmMKQEAg
LTM1LDYgKzM1LDcgQEAKICNpbmNsdWRlIDx1bmlzdGQuaD4KICNpbmNsdWRlIDxtZW1vcnkuaD4K
ICNpbmNsdWRlIDxzdHJpbmcuaD4KKyNpbmNsdWRlIDxsaW1pdHMuaD4KIAogI2RlZmluZSBOVU1f
Q0hJTERSRU4gOAogCkBAIC0xMjgsMTAgKzEyOSwxMyBAQCB2b2lkIGRpb19hcHBlbmQoY2hhciAq
ZmlsZW5hbWUsIGludCBmaWxsKQogCiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiB7
CisJY2hhciBmaWxlbmFtZVtQQVRIX01BWF07CiAJaW50IHBpZFtOVU1fQ0hJTERSRU5dOwogCWlu
dCBudW1fY2hpbGRyZW4gPSAxOwogCWludCBpOwotCWNoYXIgKmZpbGVuYW1lID0gIi90ZXN0L2Fp
b2Rpby9maWxlIjsKKworCXNucHJpbnRmKGZpbGVuYW1lLCBzaXplb2YoZmlsZW5hbWUpLCAiJXMv
YWlvZGlvL2ZpbGUiLAorCQlnZXRlbnYoIlRNUCIpID8gZ2V0ZW52KCJUTVAiKSA6ICIvdG1wIik7
CiAKIAlmb3IgKGkgPSAwOyBpIDwgbnVtX2NoaWxkcmVuOyBpKyspIHsKIAkJaWYgKChwaWRbaV0g
PSBmb3JrKCkpID09IDApIHsKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvaW8vbHRwLWFp
b2Rpby9kaXJ0eS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2RpcnR5LmMKaW5k
ZXggMWNmZjNlYy4uN2EyOGI0NCAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAt
YWlvZGlvL2RpcnR5LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9pby9sdHAtYWlvZGlvL2RpcnR5
LmMKQEAgLTMxLDE3ICszMSwyMCBAQAogI2luY2x1ZGUgPG1lbW9yeS5oPgogI2luY2x1ZGUgPHN0
ZGlvLmg+CiAjaW5jbHVkZSA8dW5pc3RkLmg+CisjaW5jbHVkZSA8bGltaXRzLmg+CiAKIGludCBt
YWluKCkKIHsKIAlpbnQgZmQ7CiAJaW50IGk7CiAJY2hhciBidWZbMzIqMTAyNF07Ci0JY2hhciBm
aWxlbmFtZVsxMDI0XTsKKwljaGFyIGZpbGVuYW1lW1BBVEhfTUFYXTsKIAotICAgIHByaW50Zigi
U3RhcnRpbmcgZGlydHkgdGVzdHMuLi5cbiIpOworCXByaW50ZigiU3RhcnRpbmcgZGlydHkgdGVz
dHMuLi5cbiIpOworCisJc25wcmludGYoZmlsZW5hbWUsIHNpemVvZihmaWxlbmFtZSksICIlcy9h
aW9kaW8vZmlsZS54eC4lZCIsCisJCWdldGVudigiVE1QIikgPyBnZXRlbnYoIlRNUCIpIDogIi90
bXAiLCBnZXRwaWQoKSk7CiAKLQlzcHJpbnRmKGZpbGVuYW1lLCAiL3Rlc3QvYWlvZGlvL2ZpbGUu
eHguJWQiLCBnZXRwaWQoKSk7CiAJZmQgPSBvcGVuKGZpbGVuYW1lLCBPX0NSRUFUfE9fV1JPTkxZ
LCAwNjY2KTsKIAogCW1lbXNldChidWYsIDB4YWEsIHNpemVvZihidWYpKTsKQEAgLTUwLDUgKzUz
LDUgQEAgaW50IG1haW4oKQogCWZzeW5jKGZkKTsKIAljbG9zZShmZCk7CiAJdW5saW5rKGZpbGVu
YW1lKTsKLSAgICByZXR1cm4gMDsKKwlyZXR1cm4gMDsKIH0K
--001636c5a4100d9c84048fcefd2e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
--001636c5a4100d9c84048fcefd2e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001636c5a4100d9c84048fcefd2e--

