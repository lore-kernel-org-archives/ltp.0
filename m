Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <suzuki@in.ibm.com>) id 1OxE9Y-0001IM-Pr
	for ltp-list@lists.sourceforge.net; Sun, 19 Sep 2010 07:17:36 +0000
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OxE9X-0008VG-2f
	for ltp-list@lists.sourceforge.net; Sun, 19 Sep 2010 07:17:36 +0000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id o8J7HRb7021360
	for <ltp-list@lists.sourceforge.net>; Sun, 19 Sep 2010 17:17:27 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8J7HRAB2408686
	for <ltp-list@lists.sourceforge.net>; Sun, 19 Sep 2010 17:17:27 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8J7HQo9020581
	for <ltp-list@lists.sourceforge.net>; Sun, 19 Sep 2010 17:17:26 +1000
Message-ID: <4C95B904.3070404@in.ibm.com>
Date: Sun, 19 Sep 2010 12:47:24 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
References: <1282116783.4855.8.camel@PEK-RLIANG-D1>
	<AANLkTikrFeTSbiWY4EhotU7siB_vw8hVF_FWtSNREr8x@mail.gmail.com>
	<1283219506.1778.2.camel@PEK-RLIANG-D1>
	<AANLkTin=MTu4QGB-+zyYQh=qMLprgjx6txisF4r_5xPT@mail.gmail.com>
	<AANLkTikH16Evfuj0RXkYLUYy6msPf2DcwD+zXzhhFV_+@mail.gmail.com>
	<1284874992.12271.5.camel@PEK-RLIANG-D1>
	<4C95AF8A.8000803@in.ibm.com>
	<1284878205.12271.9.camel@PEK-RLIANG-D1>
	<4C95B7D9.5060801@in.ibm.com>
In-Reply-To: <4C95B7D9.5060801@in.ibm.com>
Content-Type: multipart/mixed; boundary="------------080400010603080109040008"
Subject: Re: [LTP] [Patch] Fix mtest06 failure: caught unexpected signal -
 11 --- exiting
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
To: renxiu liang <renxiu.liang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080400010603080109040008
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Here is a patch which I had, sometime back. It is on an older version of 
LTP.

Cheers

Suzuki


, Suzuki Poulose wrote:
> , renxiu liang wrote:
>> On Sun, 2010-09-19 at 12:06 +0530, Suzuki Poulose wrote:
>>> Hello Renxiu,
>>>
>>> Sorry for the late reply. Could you please resend the patch ? I don't
>>> find the patch in the e-mail.
>>>
>> Hi Suzuki
>>
>> attached failure logs on different archs and patch for you.
>
> I don't understand why there should be ACCERR. The mmap is done with
> PROT_WRIT|PROT_READ. Could we get more info on which condition triggers
> this ?
>
> You may use GDB to break for the ACCERR case and take a look at the
> instruction which triggers this.
>
> Coming back to your patch :
>
> I think we should ensure the si_addr is within the map. (map_address,
> map_address+mapsize-1) ? We should not let the other SIGSEGVs go through.
>
> It may be like :
>
> case SIGSEGV:
> if ((si_addr >= map_address) &&
> (si_addr < (map_address + map_size) ) {
> ...
> ..
> }
>
>
> Thanks
>
> Suzuki
>
>
>
>
>>
>> thanks for help review this.
>>
>> BR
>> Renxiu
>>> Thanks
>>>
>>> Suzuki
>>> , renxiu liang wrote:
>>>> On Wed, 2010-09-01 at 00:27 -0700, Garrett Cooper wrote:
>>>>> On Wed, Sep 1, 2010 at 12:26 AM, Garrett Cooper<yanegomi@gmail.com>
>>>>> wrote:
>>>>>> On Mon, Aug 30, 2010 at 6:51 PM, renxiu liang
>>>>>> <renxiu.liang@windriver.com> wrote:
>>>>>>> On Wed, 2010-08-25 at 20:36 -0700, Garrett Cooper wrote:
>>>>>>>> On Wed, Aug 18, 2010 at 12:33 AM, renxiu liang
>>>>>>>> <renxiu.liang@windriver.com> wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> We met the mtest06 failure several times; this is because in
>>>>>>>>> mtest06/mmap1.c, when handling the signal 11 in sig_handler, it
>>>>>>>>> doesn't
>>>>>>>>> cover another two race conditions:
>>>>>>>>> one is si_code equals "SEGV_MAPERR" but si_address does not
>>>>>>>>> equal to
>>>>>>>>> map_address; and one is si_code equals to "SEGV_ACCERR";
>>>>>>>>>
>>>>>>>>> see below error log:
>>>>>>>>>
>>>>>>>>> <<<test_start>>>
>>>>>>>>> tag=mtest06 stime=1270902396
>>>>>>>>> cmdline=" mmap1 -x 0.05"
>>>>>>>>> contacts=""
>>>>>>>>> analysis=exit
>>>>>>>>> initiation_status="ok"
>>>>>>>>> <<<test_output>>>
>>>>>>>>> mmap1 0 INFO : pid[5456]: map, change contents, unmap files
>>>>>>>>> 1000 times
>>>>>>>>> mmap1 0 INFO : created thread[1216369840]
>>>>>>>>> mmap1 0 INFO : pid[5456] - read contents of memory 0x48002000
>>>>>>>>> 1000 times
>>>>>>>>> mmap1 0 INFO : page fault occurred at 0x48002000
>>>>>>>>> mmap1 0 INFO : page fault occurred at 0x48002000
>>>>>>>>> mmap1 0 INFO : page fault occurred at 0x48002000
>>>>>>>>> mmap1 0 INFO : page fault occurred at 0x48002000
>>>>>>>>> ......
>>>>>>>>> mmap1 0 INFO : page fault occurred at 0x48002000
>>>>>>>>> mmap1 0 INFO : page fault occurred at 0x48002000
>>>>>>>>> caught unexpected signal - 11 --- exiting
>>>>>>>>> <<<execution_status>>>
>>>>>>>>> duration=1 termination_type=exited termination_id=255 corefile=no
>>>>>>>>> cutime=0 cstime=4
>>>>>>>>> <<<test_end>>>
>>>>>>>>>
>>>>>>>>> I made a patch to cover all the three race conditions in one
>>>>>>>>> case in
>>>>>>>>> sig_handler(),
>>>>>>>>> then run mtest06 repeatedly on different archs, test will not
>>>>>>>>> fail by
>>>>>>>>> catching signal 11.
>>>>>>>>
>>>>>>>> Could you print out what the value of info->si_code and
>>>>>>>> info->si_addr
>>>>>>>> are at the time of the fault? Also, which architecture(s) are you
>>>>>>>> running into this issue on?
>>>>>>> Hi Garrett,
>>>>>>>
>>>>>>> Sorry for the late reply; See attached mtest06 logs, I printed
>>>>>>> out the
>>>>>>> values of si_code, si_addr, map_address;
>>>>>>> it is reproducible on arm, x86, ppc and mips; though it is not
>>>>>>> reproducible every time, but can be reproducible if run the case
>>>>>>> repeatedly.
>>>>>>
>>>>>> Nothing is jumping out at me as being incorrect, so I think it's best
>>>>>> that I bring in a better pair of eyes, just in case.
>>>>>>
>>>>>> Suzuki-san,
>>>>>> Could you please help review this patch?
>>>>>
>>>> Hi Garrett,
>>>> No reply from Suzuki-san after almost three weeks; I'm afraid
>>>> Suzuki-san
>>>> didn't catch the mail, could you find someone else to review the patch?
>>>> thanks!
>>>>
>>>> BR,
>>>> Renxiu
>>>>
>>>>> CCing Suzuki-san...
>>>>> -Garrett
>>>>
>>>
>>
>


--------------080400010603080109040008
Content-Type: text/plain;
 name="mtest06-mmap1.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="mtest06-mmap1.diff"

ZGlmZiAtTmF1ciBsdHAtZnVsbC0yMDA5MTIzMS5vcmlnL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L210ZXN0MDYvbW1hcDEuYyBsdHAtZnVsbC0yMDA5MTIzMS90ZXN0Y2FzZXMva2VybmVsL21l
bS9tdGVzdDA2L21tYXAxLmMKLS0tIGx0cC1mdWxsLTIwMDkxMjMxLm9yaWcvdGVzdGNhc2Vz
L2tlcm5lbC9tZW0vbXRlc3QwNi9tbWFwMS5jCTIwMDktMTAtMTMgMTk6MzA6NDYuMDAwMDAw
MDAwICswNTMwCisrKyBsdHAtZnVsbC0yMDA5MTIzMS90ZXN0Y2FzZXMva2VybmVsL21lbS9t
dGVzdDA2L21tYXAxLmMJMjAxMC0wMy0xNSAxNjozMDozMy4wMDAwMDAwMDAgKzA1MzAKQEAg
LTEzOCw2ICsxMzgsNyBAQAogaW50IAkgICB2ZXJib3NlX3ByaW50ID0gRkFMU0U7Lyogd2hl
biBjYWxsZWQgd2l0aCAtdiBwcmludCBtb3JlIGluZm8gICAgICAgKi8KIGNhZGRyX3QgICAg
Km1hcF9hZGRyZXNzOwkvKiBhZGRyZXNzIG9mIHRoZSBmaWxlIG1hcHBlZC4JICAgICAgICAg
ICAgICAqLwogc2lnam1wX2J1ZiBqbXBidWY7CQkvKiBhcmd1bWVudCB0byBzaWdzZXRqbXAg
YW5kIHNpZ2xvbmdqbXAgICAgICAgKi8KK2xvbmcJICAgbWFwX2xlbjsKIAogY2hhciAqVENJ
RCA9ICJtbWFwMSI7CiBpbnQgVFNUX1RPVEFMID0gMTsKQEAgLTE2OCwxNCArMTY5LDIyIEBA
CiAgICAgICAgICAgICAgX2V4aXQoMCk7CiAKICAgICAgICAgY2FzZSBTSUdTRUdWOgotICAg
ICAgICAgICAgIGlmIChpbmZvLT5zaV9jb2RlID09IFNFR1ZfTUFQRVJSICYmCi0gICAgICAg
ICAgICAgICAgICAgICAgaW5mby0+c2lfYWRkciA9PSBtYXBfYWRkcmVzcykKKyAgICAgICAg
ICAgICBpZiAoIGluZm8tPnNpX2FkZHIgPT0gbWFwX2FkZHJlc3MgfHwKKwkJIChtYXBfYWRk
cmVzcyAmJiAoaW5mby0+c2lfYWRkciA+PSAodm9pZCopIG1hcF9hZGRyZXNzICYmCisJCQkJ
IGluZm8tPnNpX2FkZHIgPCAodm9pZCAqKSgobG9uZyltYXBfYWRkcmVzcyArIG1hcF9sZW4p
KQorCQkgICkKKwkJKQogICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgIHRzdF9y
ZXNtKFRJTkZPLAogICAgICAgICAgICAgICAgICAgICAicGFnZSBmYXVsdCBvY2N1cnJlZCBh
dCAlcCIsCiAgICAgICAgICAgICAgICAgICAgIG1hcF9hZGRyZXNzKTsKICAgICAgICAgICAg
ICAgICAgIGxvbmdqbXAoam1wYnVmLCAxKTsKLSAgICAgICAgICAgICB9CisgICAgICAgICAg
ICAgfSBlbHNlIHsKKyAgICAgICAgICAgIAkgIGZwcmludGYoc3RkZXJyLCAiY2F1Z2h0IFNJ
R1NFR1YgYXQgJXAgd2hpbGUgbW1hcCBpcyAoJXAsJXApIC0gIGV4aXRpbmdcbiIsCisJCQkJ
aW5mby0+c2lfYWRkciwgbWFwX2FkZHJlc3MsICh2b2lkKikoKGxvbmcpbWFwX2FkZHJlc3Mg
KyBtYXBfbGVuKSk7CisJCSAgX2V4aXQoLTEpOworCSAgICAgfQorCQkKICAgICAgICAgZGVm
YXVsdDoKICAgICAgICAgICAgIGZwcmludGYoc3RkZXJyLCAiY2F1Z2h0IHVuZXhwZWN0ZWQg
c2lnbmFsIC0gJWQgLS0tIGV4aXRpbmdcbiIsCiAgICAgICAgICAgICAgICAgICAgICBzaWdu
YWwpOwpAQCAtMjkzLDYgKzMwMiw5IEBACiAJCSAgICAgICAobG9uZyAqKWFyZ3M7CiAgICAg
bG9uZyBleGl0X3ZhbCA9IDA7ICAvKiBleGl0IHZhbHVlIG9mIHRoZSBwdGhyZWFkCQkgICAg
ICAqLwogCisgICAgLyogVGhlIHNpemUgb2YgdGhlIG1hcCAqLworICAgIG1hcF9sZW4gPSBt
d3VhcmdzWzFdOworCiAgICAgdHN0X3Jlc20oVElORk8sICJwaWRbJWRdOiBtYXAsIGNoYW5n
ZSBjb250ZW50cywgdW5tYXAgZmlsZXMgJWQgdGltZXMiLAogCQlnZXRwaWQoKSwgKGludClt
d3VhcmdzWzJdKTsKICAgICBpZiAodmVyYm9zZV9wcmludCkK
--------------080400010603080109040008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
--------------080400010603080109040008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080400010603080109040008--

