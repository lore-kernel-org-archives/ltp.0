Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P8red-00063X-Hn
	for ltp-list@lists.sourceforge.net; Thu, 21 Oct 2010 09:41:47 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P8rec-0007pY-AV
	for ltp-list@lists.sourceforge.net; Thu, 21 Oct 2010 09:41:47 +0000
Received: by wwb17 with SMTP id 17so3667137wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 21 Oct 2010 02:41:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimwwvYMxECHENzqo6tb4iVU+VCbT12aWhUagppF@mail.gmail.com>
References: <000001cb66a9$bb3c52b0$31b4f810$@co.jp>
	<AANLkTimwwvYMxECHENzqo6tb4iVU+VCbT12aWhUagppF@mail.gmail.com>
Date: Thu, 21 Oct 2010 02:41:40 -0700
Message-ID: <AANLkTikxqHqzGGcASkgMLq2BAWxLGHxjgvSbtsguXDzb@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016e64967c841af4b04931d553c
Subject: Re: [LTP] POSIX "aio_return/2-1" failed.
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

--0016e64967c841af4b04931d553c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 18, 2010 at 5:00 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Thu, Oct 7, 2010 at 10:29 PM, Mitani <mitani@ryobi.co.jp> wrote:
>> Hi,
>>
>>
>> "conformance/interfaces/aio_return/2-1" failed with following message:
>> ------------
>> conformance/interfaces/aio_return/2-1: execution: FAILED: Output:
>> aio_return/2-1.c Second call to aio_return() should return -1 : 111
>> ------------
>>
>> Same problem occurs in "aio_return/3-2.c" and "aio_return/4-1".
>>
>> Environment is as follows:
>> =A0- RHEL5.5 --- (x86, x86_64, ia64)
>> =A0- RHEL4.8 --- (x86, x86_64, ia64)
>>
>>
>> This testset seems to be the error root test for "aio_return()".
>>
>> First "aio_return()" returned with 111. This return value is the length
>> of buffer of "aio_write()".
>> But second "aio_return()" returned with 111, too. It's unexpected
>> result for this test set.
>> Therefore, this test failed.
>>
>> Man page says that
>> "This function should be called only once for any given request, =A0afte=
r
>> aio_error(2) returns something other than EINPROGRESS.":
>> ------------
>> # LANG=3DC man 3 aio_return
>>
>> AIO_RETURN(3) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Linux Programmer's Manu=
al
>> AIO_RETURN(3)
>>
>> NAME
>> =A0 =A0 =A0 aio_return - get return status of asynchronous I/O operation
>>
>> SYNOPSIS
>> =A0 =A0 =A0 #include <aio.h>
>>
>> =A0 =A0 =A0 ssize_t aio_return(struct aiocb *aiocbp);
>>
>> DESCRIPTION
>> =A0 =A0 =A0 The aio_return function returns the final return status for =
the
>> asynchronous I/O
>> =A0 =A0 =A0 request with control block pointed to by aiocbp.
>>
>> =A0 =A0 =A0 This =A0function =A0should =A0be =A0called =A0only =A0once =
=A0for =A0any =A0given
>> request, =A0after
>> =A0 =A0 =A0 aio_error(2) returns something other than EINPROGRESS.
>>
>> RETURN VALUE
>> =A0 =A0 =A0 If the asynchronous I/O operation has completed, this functi=
on
>> returns the value
>> =A0 =A0 =A0 that would have been returned in case of a synchronous =A0re=
ad, =A0write,
>> or =A0fsync
>> =A0 =A0 =A0 request. =A0Otherwise the return value is undefined. =A0On e=
rror, the
>> error value is
>> =A0 =A0 =A0 returned.
>>
>> ERRORS
>> =A0 =A0 =A0 EINVAL aiocbp does not point at a control block for an async=
hronous
>> I/O =A0request
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0of which the return status has not been retri=
eved yet.
>>
>> CONFORMING TO
>> =A0 =A0 =A0 POSIX 1003.1-2003
>>
>> SEE ALSO
>> =A0 =A0 =A0 aio_cancel(3), =A0 =A0aio_error(3), =A0 aio_fsync(3), =A0 ai=
o_read(3),
>> aio_suspend(3),
>> =A0 =A0 =A0 aio_write(3)
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 2003-11-14
>> AIO_RETURN(3)
>> #
>> ------------
>>
>> And, it says that
>> "If the asynchronous I/O operation has completed, this function returns
>> the value that would have been returned in case of a synchronous read,
>> write, or fsync request. =A0Otherwise the return value is undefined. =A0=
On
>> error, the error value is returned.".
>>
>>
>> It can be supposed that the return value of second "aio_return()" is
>> undefined.
>> Therefore, it is not mistake that return value of the second "aio_return=
()"
>> is one at success, I think.
>> And, I think that "UNTESTED" or "UNRESOLVED" may be is more appropriate
>> for this test.
>
> =A0 =A0No. POSIX clearly states:
>
> "If the asynchronous I/O operation has completed, then the return
> status, as described for read(), write(), and fsync(), shall be
> returned. If the asynchronous I/O operation has not yet completed, the
> results of aio_return() are undefined.
>
> If the aio_return() function fails, it shall return -1 and set errno
> to indicate the error."
>
> ERRORS
>
> "The aio_return() function may fail if:
>
> [EINVAL]
> =A0 =A0The aiocbp argument does not refer to an asynchronous operation
> whose return status has not yet been retrieved."
>
> =A0 =A0What the test implementers were looking to do was test out that -1
> / EINVAL were returned, and maybe that fact that they were testing was
> in fact implementation defined, as opposed to what's stated in the
> standard, as the spec doesn't state that the behavior for aio_return
> would be s.t. the state of the AIO stream is reset when aio_return is
> called.
> =A0 =A0So yes, I agree this should be fixed, but let me check with the
> POSIX folks what the best course of action is.

    I've read into this a bit more, and I think that the aio_return
testcases were written incorrectly. Please try out this testcase... if
it works for you, then I'll apply necessary logic to other testcases
as well.
    It worked for me at least on FreeBSD.
Thanks,
-Garrett

--0016e64967c841af4b04931d553c
Content-Type: application/octet-stream; name="fixup-aio_return-1-1.diff"
Content-Disposition: attachment; filename="fixup-aio_return-1-1.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gfjfxmb10

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9p
bnRlcmZhY2VzL2Fpb19yZXR1cm4vMS0xLmMgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3Vp
dGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9haW9fcmV0dXJuLzEtMS5jCmluZGV4IGJmYzhlMTIu
LjA5MDM4N2MgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25m
b3JtYW5jZS9pbnRlcmZhY2VzL2Fpb19yZXR1cm4vMS0xLmMKKysrIGIvdGVzdGNhc2VzL29wZW5f
cG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvYWlvX3JldHVybi8xLTEuYwpA
QCAtNDMsOCArNDMsMTAgQEAgaW50IG1haW4odm9pZCkKIAlzdHJ1Y3QgYWlvY2IgYWlvY2I7CiAJ
aW50IGZkLCByZXR2YWw7CiAKKyNpZiAwCiAJaWYgKHN5c2NvbmYoX1NDX0FTWU5DSFJPTk9VU19J
TykgIT0gMjAwMTEyTCkKIAkJcmV0dXJuIFBUU19VTlNVUFBPUlRFRDsKKyNlbmRpZgogCiAJc25w
cmludGYodG1wZm5hbWUsIHNpemVvZih0bXBmbmFtZSksICIvdG1wL3B0c19haW9fcmV0dXJuXzFf
MV8lZCIsIAogCQkgIGdldHBpZCgpKTsKQEAgLTczLDI2ICs3NSwxOCBAQCBpbnQgbWFpbih2b2lk
KQogCQlleGl0KFBUU19GQUlMKTsKIAl9CiAKLQlkbyB7Ci0JCXJldHZhbCA9IGFpb19lcnJvcigm
YWlvY2IpOwotCQlpZiAocmV0dmFsID09IC0xKSB7Ci0JCQljbG9zZShmZCk7Ci0JCQlwcmludGYo
VE5BTUUgIiBFcnJvciBhdCBhaW9fZXJyb3IoKTogJXNcbiIsCi0JCQkJc3RyZXJyb3IoZXJybm8p
KTsKLQkJCWV4aXQoUFRTX0ZBSUwpOwotCQl9Ci0JfSB3aGlsZSAocmV0dmFsID09IEVJTlBST0dS
RVNTKTsKLQorCXdoaWxlIChhaW9fZXJyb3IoJmFpb2NiKSA9PSBFSU5QUk9HUkVTUykKKwkJc2xl
ZXAoMSk7CiAJcmV0dmFsID0gYWlvX3JldHVybigmYWlvY2IpOwogCi0JaWYgKHJldHZhbCAhPSBC
VUZfU0laRSkgewotCQljbG9zZShmZCk7CisJaWYgKHJldHZhbCA9PSAtMSkgewogCQlwcmludGYo
VE5BTUUgIiBFcnJvciBhdCBhaW9fcmV0dXJuKCk6ICVzXG4iLAotCQkgICAgICAgc3RyZXJyb3Io
ZXJybm8pKTsKKwkJICAgICAgIHN0cmVycm9yKGFpb19lcnJvcigmYWlvY2IpKSk7CiAJCWV4aXQo
UFRTX0ZBSUwpOwogCX0KLQkKKwogCWNsb3NlKGZkKTsKKwlwcmludGYoImFpb19yZXR1cm4oJmFp
b2NiKSA9ICVkXG4iLCByZXR2YWwpOwogCXByaW50ZigiVGVzdCBQQVNTRURcbiIpOwogCWV4aXQo
UFRTX1BBU1MpOwogfQo=
--0016e64967c841af4b04931d553c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
--0016e64967c841af4b04931d553c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016e64967c841af4b04931d553c--

