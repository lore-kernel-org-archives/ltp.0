Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P2l5W-0004Hy-Gx
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 13:28:18 +0000
Received: from mail-gw0-f47.google.com ([74.125.83.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P2l5V-0003wp-72
	for ltp-list@lists.sourceforge.net; Mon, 04 Oct 2010 13:28:18 +0000
Received: by gwb1 with SMTP id 1so2115785gwb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 04 Oct 2010 06:28:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CA9D0EB.5090309@st.com>
References: <4CA09D4D.6050708@st.com> <4CA34070.9070505@st.com>
	<20100930133120.GA4070@hannu-debian.research.nokia.com>
	<4CA469A0.5090700@st.com> <20101001040609.GA2090@hannu-ubuntu>
	<4CA9D0EB.5090309@st.com>
Date: Mon, 4 Oct 2010 06:28:11 -0700
Message-ID: <AANLkTim_Ay4yjdBfm8tzEiK_z4JzQyg6RRsR3E1tCH9h@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016367b6eca0724e10491ca8496
Subject: Re: [LTP] ltp_clone alignment issues.
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
To: Carmelo AMOROSO <carmelo.amoroso@st.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--0016367b6eca0724e10491ca8496
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Oct 4, 2010 at 6:04 AM, Carmelo AMOROSO <carmelo.amoroso@st.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 10/1/2010 6:06 AM, Hannu Heikkinen wrote:
>> On 30/09/10 12:42 +0200, Carmelo AMOROSO wrote:
>> On 9/30/2010 3:31 PM, Hannu Heikkinen wrote:
>>> On 29/09/10 15:34 +0200, ext Carmelo AMOROSO wrote:
>>> > -----BEGIN PGP SIGNED MESSAGE-----
>>> > Hash: SHA1
>>> >
>>> > On 9/27/2010 3:34 PM, Carmelo AMOROSO wrote:
>>> > > Folks,
>>> > > I want to reopen an old discussion on ltp_clone and stack alignment
>>> > > issue (see
>>> > >
>>
>>> http://sourceforge.net/mailarchive/message.php?msg_name=4B421480.1040400%40petalogix.com).
>>> > > Indeed recently a commit has partially fixed a problem on ARM
>>> > > (0056e395170eb8fc3ffbb22d7bd364fe47c2013e), but I think this should be
>>> > > extended to all archs that have stack that grows downwards.
>>> > >
>>> > > Indeed, as Jiri replied in that old thread, the value passed to clone as
>>> > > child stack should be never accessed, because it is the topmost address
>>> > > of the memory allocated for the child process (it's the previous stack
>>> > > pointer).
>>> > >
>>> > > So, in archs that do not like unaligned stack, using (stack - size - 1 )
>>> > > will cause the process to be killed by a SIGBUS, on other archs, we are
>>> > > just wasting one byte of the malloc-ed stack.
>>> > >
>>> > > On my SH4 arch, the stack must be 4byte aligned (as in ARM).
>>> > >
>>> > > Please, find attached a patch against master branch
>>> > >
>>> > > Best regards,
>>> > > Carmelo
>>> >
>>> > Hi,
>>> > any feedback on this ?
>>> >
>>> > Cheers,
>>> > Carmelo
>>
>>> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
>>> Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
>>> ---
>>> lib/cloner.c | 9 +++------
>>> 1 files changed, 3 insertions(+), 6 deletions(-)
>>
>>> diff --git a/lib/cloner.c b/lib/cloner.c
>>> index 6ad4a00..e53c9cf 100644
>>> --- a/lib/cloner.c
>>> +++ b/lib/cloner.c
>>> @@ -59,16 +59,13 @@ ltp_clone(unsigned long clone_flags, int (*fn)(void
>>> *arg), void *arg,
>>> ret = clone(fn, stack, clone_flags, arg);
>>> #elif defined(__ia64__)
>>> ret = clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL,
>>> NULL);
>>> -#elif defined(__arm__)
>>> +#else
>>> /*
>>> - * Stack size should be a multiple of 32 bit words
>>> - * & stack limit must be aligned to a 32 bit boundary
>>> + * For archs where stack grows downwards, stack points to the topmost
>>> address
>>> + * of the memory space set up for the child stack.
>>> */
>>> ret = clone(fn, (stack ? stack + stack_size : NULL),
>>> clone_flags, arg);
>>> -#else
>>> - ret = clone(fn, (stack ? stack + stack_size - 1 : NULL),
>>> - clone_flags, arg);
>>> #endif
>>
>>> return ret;
>>> --
>>> <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
>>
>>> Hi,
>>
>>> Acked-by Hannu Heikkinen <ext-hannu.m.heikkinen@nokia.com>
>>
>>> Br,
>>> Hannu
>>
>>> --
>>> Hannu Heikkinen
>>> http://www.nixu.com
>>
>>
>> Thanks, Hannu
>
>> Hi,
>
>> I was thinking your patch once again, and I think it would be wiser if
>> we would have something like:
>
>> --- ../tmp2/ltp-full-20100630/lib/cloner.c 2010-07-03 21:29:04.000000000
>> +0300
>> +++ lib/cloner.c 2010-09-03 14:48:20.000000000 +0300
>> @@ -43,6 +43,16 @@
>> pid_t *parent_tid, void *tls, pid_t *child_tid);
>> #endif
>
>> +/*
>> + * Most arch really want to have stack aligned to some sane boundary.
>> + */
>> +#ifdef __arm__
>> +#define ALIGN_STACK(stack) \
>> + ((void *)(((unsigned long)stack) & ~((sizeof(void *)) - 1)))
>> +#else
>> +#define ALIGN_STACK(stack) (stack)
>> +#endif
>> +
>> /***********************************************************************
>> * ltp_clone: wrapper for clone to hide the architecture dependencies.
>> * 1. hppa takes bottom of stack and no stacksize (stack grows up)
>> @@ -60,7 +70,7 @@
>> #elif defined(__ia64__)
>> ret = clone2(fn, stack, stack_size, clone_flags, arg, NULL, NULL,
>> NULL);
>> #else
>> - ret = clone(fn, (stack ? stack + stack_size - 1 : NULL),
>> + ret = clone(fn, (stack ? ALIGN_STACK(stack + stack_size - 1) : NULL),
>> clone_flags, arg);
>> #endif
>
>
>> The above patch iis in use in our ARM based LTP test suite. Note that -1 is
>> needed for not clobbering eg possibly malloced area after child stack.
>> Could u please change that prev patch a bit, for ensuring that child stack
>> is in proper size etc. Above patch is not sufficient, because ALIGN_STACK
>> in that is only used for arm archs.
>
>> br,
>> Hannu
>
>
> Hannu,
> I don't think that it is a good to force the alignment; we could need to
> write a test case that calls LTP_clone with an unaligned stack just to
> test the behavior of the clone implementation.
>
> Likely, it should be useful to add a check inside the C lib clone
> implementation (arch specific) to protect against unaligned stack, but
> this is a different matter.
>
> I would just leave the LTP_clone passing the argument to the clone as
> they came from the caller.

    I believe this is already handled to some degree with the clone
testcases. If not that should be added and I'll review patches which
add this testing to LTP.
    On a semi-unrelated note could you guys please test out the
attached patch to make sure that there isn't a functional difference
if you have access to ia64, s390, etc?
Thanks,
-Garrett

--0016367b6eca0724e10491ca8496
Content-Type: application/octet-stream; name="remove-clone-platform.diff"
Content-Disposition: attachment; filename="remove-clone-platform.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gevdj38o0

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2xvbmUvY2xvbmUwMS5jIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jbG9uZS9jbG9uZTAxLmMKaW5kZXggODk5OTJhNi4u
ZGVmODAwNyAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jbG9uZS9jbG9u
ZTAxLmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jbG9uZS9jbG9uZTAxLmMKQEAg
LTc5LDcgKzc5LDYgQEAKICNpbmNsdWRlIDxzeXMvd2FpdC5oPgogI2luY2x1ZGUgInRlc3QuaCIK
ICNpbmNsdWRlICJ1c2N0ZXN0LmgiCi0jaW5jbHVkZSAiY2xvbmVfcGxhdGZvcm0uaCIKIAogc3Rh
dGljIHZvaWQgc2V0dXAoKTsKIHN0YXRpYyB2b2lkIGNsZWFudXAoKTsKZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2xvbmUvY2xvbmUwMi5jIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9jbG9uZS9jbG9uZTAyLmMKaW5kZXggZTY1NzAyZS4uNzE4YWI0NyAxMDA2NDQK
LS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jbG9uZS9jbG9uZTAyLmMKKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jbG9uZS9jbG9uZTAyLmMKQEAgLTExMyw4ICsxMTMsNiBA
QAogI2RlZmluZSBUUlVFIDEKICNkZWZpbmUgRkFMU0UgMAogCi0jaW5jbHVkZSAiY2xvbmVfcGxh
dGZvcm0uaCIKLQogc3RhdGljIHZvaWQgc2V0dXAoKTsKIHN0YXRpYyBpbnQgdGVzdF9zZXR1cCgp
Owogc3RhdGljIHZvaWQgY2xlYW51cCgpOwpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9jbG9uZS9jbG9uZTAzLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Nsb25l
L2Nsb25lMDMuYwppbmRleCAyZDYwY2ViLi4wYTQ5NjYyIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2Nsb25lL2Nsb25lMDMuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2Nsb25lL2Nsb25lMDMuYwpAQCAtNzcsOCArNzcsNiBAQAogI2luY2x1ZGUgInRlc3Qu
aCIKICNpbmNsdWRlICJ1c2N0ZXN0LmgiCiAKLSNpbmNsdWRlICJjbG9uZV9wbGF0Zm9ybS5oIgot
CiBzdGF0aWMgdm9pZCBzZXR1cCgpOwogc3RhdGljIHZvaWQgY2xlYW51cCgpOwogc3RhdGljIGlu
dCBjaGlsZF9mbigpOwpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jbG9u
ZS9jbG9uZTA0LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Nsb25lL2Nsb25lMDQuYwpp
bmRleCBmNTAxNmY3Li5jMTRmZDgxIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2Nsb25lL2Nsb25lMDQuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Nsb25l
L2Nsb25lMDQuYwpAQCAtNzYsNyArNzYsNiBAQAogI2luY2x1ZGUgPHN5cy93YWl0Lmg+CiAjaW5j
bHVkZSAidGVzdC5oIgogI2luY2x1ZGUgInVzY3Rlc3QuaCIKLSNpbmNsdWRlICJjbG9uZV9wbGF0
Zm9ybS5oIgogCiBzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpOwogc3RhdGljIHZvaWQgc2V0dXAo
dm9pZCk7CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Nsb25lL2Nsb25l
MDUuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2xvbmUvY2xvbmUwNS5jCmluZGV4IDcz
Y2EyZTYuLjIwMTg1ODEgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2xv
bmUvY2xvbmUwNS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2xvbmUvY2xvbmUw
NS5jCkBAIC03NSw3ICs3NSw2IEBACiAjaW5jbHVkZSA8c3lzL3dhaXQuaD4KICNpbmNsdWRlICJ0
ZXN0LmgiCiAjaW5jbHVkZSAidXNjdGVzdC5oIgotI2luY2x1ZGUgImNsb25lX3BsYXRmb3JtLmgi
CiAKICNkZWZpbmUgRkxBRyBDTE9ORV9WTSB8IENMT05FX1ZGT1JLCiAKZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2xvbmUvY2xvbmUwNi5jIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9jbG9uZS9jbG9uZTA2LmMKaW5kZXggYTRkNmYwNy4uNzRjNGM4YSAxMDA2NDQK
LS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jbG9uZS9jbG9uZTA2LmMKKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jbG9uZS9jbG9uZTA2LmMKQEAgLTgxLDcgKzgxLDYgQEAK
ICNpbmNsdWRlIDxmY250bC5oPgogI2luY2x1ZGUgInRlc3QuaCIKICNpbmNsdWRlICJ1c2N0ZXN0
LmgiCi0jaW5jbHVkZSAiY2xvbmVfcGxhdGZvcm0uaCIKIAogI2RlZmluZSBNQVhfTElORV9MRU5H
VEggMjU2CiAKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2xvbmUvY2xv
bmUwNy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jbG9uZS9jbG9uZTA3LmMKaW5kZXgg
ZjY4MDk5YS4uY2Q5MjdhNSAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9j
bG9uZS9jbG9uZTA3LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jbG9uZS9jbG9u
ZTA3LmMKQEAgLTc4LDcgKzc4LDYgQEAKICNpbmNsdWRlIDxzeXMvd2FpdC5oPgogI2luY2x1ZGUg
InRlc3QuaCIKICNpbmNsdWRlICJ1c2N0ZXN0LmgiCi0jaW5jbHVkZSAiY2xvbmVfcGxhdGZvcm0u
aCIKIAogI2RlZmluZSBUUlVFIDEKICNkZWZpbmUgRkFMU0UgMAo=
--0016367b6eca0724e10491ca8496
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization is moving to the mainstream and overtaking non-virtualized
environment for deploying applications. Does it make network security 
easier or more difficult to achieve? Read this whitepaper to separate the 
two and get a better understanding.
http://p.sf.net/sfu/hp-phase2-d2d
--0016367b6eca0724e10491ca8496
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016367b6eca0724e10491ca8496--

