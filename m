Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1OJcFe-0004Gf-0e
	for ltp-list@lists.sourceforge.net; Wed, 02 Jun 2010 00:56:10 +0000
Received: from mail-vw0-f46.google.com ([209.85.212.46])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OJcFd-0002DO-2t
	for ltp-list@lists.sourceforge.net; Wed, 02 Jun 2010 00:56:09 +0000
MIME-Version: 1.0
In-Reply-To: <x2y42aa607e1005032014se4159c89z95d2b670b7195df5@mail.gmail.com>
References: <103530624.1121001272433642504.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<8B8139E0-F07A-433D-B38D-30DAB81E3FF5@gmail.com>
	<s2r700385ec1004272327n8b26491bt3609f8877b71a385@mail.gmail.com>
	<m2z42aa607e1004301227tfec6a200kda741f32b6feeb11@mail.gmail.com> 
	<x2l364299f41004301315x20fa3ed6u488dc923334fd5d6@mail.gmail.com> 
	<q2w42aa607e1004301556s76e89e8nf68d4bee860da4bd@mail.gmail.com> 
	<u2u364299f41004301941pe0e04112u34e7da16e7d1f3df@mail.gmail.com> 
	<x2y42aa607e1005032014se4159c89z95d2b670b7195df5@mail.gmail.com>
From: Henry Yei <hyei@mvista.com>
Date: Tue, 1 Jun 2010 17:55:42 -0700
Message-ID: <AANLkTimmc26-PkENwwuVG6dzu6BamzfSbmE_rjX9_5Mm@mail.gmail.com>
Content-Type: multipart/mixed; boundary=001485e988e4ce1f390488018d23
Subject: Re: [LTP] UTIMENSAT test fails hugely
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

--001485e988e4ce1f390488018d23
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I just wanted to see if there was still interest in the patch from
this thread last month.

Henry Yei <hyei@mvista.com>


On Mon, May 3, 2010 at 8:14 PM, Henry Yei <hyei@mvista.com> wrote:
> Garrett,
>
> This patch installs the trap for cleanup_test which removes the
> sudoers file only if it was installed by utimensat script, and also
> takes care of detecting whether sudo knows about the -n option.
>
> Signed-Off-By: <hyei@mvista.com>
>
>
> The patch was generated from ltp-dev git tree.
>
> I didn't realize Caspar's patch hadn't already been incorporated yet,
> so didn't account for it.
>
> Henry Yei <hyei@mvista.com>
>
>
> On Fri, Apr 30, 2010 at 7:41 PM, Garrett Cooper <yanegomi@gmail.com> wrot=
e:
>> On Fri, Apr 30, 2010 at 3:56 PM, Henry Yei <hyei@mvista.com> wrote:
>>> If a sudo file exists, the patch doesn't touch it. If it does not, a
>>> sudoers file will be created and then it will remove it afterwards. I
>>> wouldn't feel confortable having a script modify a sudoers file if it
>>> already exists. The sudoers content that it does put in place just
>>> enables the root user to use sudo, which would not give it any more
>>> access than it already has. This text is available in every sudoers
>>> file I've looked at.
>>>
>>>
>>>
>>> While I was testing the patch with the ltp-dev branch, I noticed that
>>> the -n option was put in front of every sudo call in commit
>>> 2aa40f7e10518977881b933cc93b8f50847cf3cf in order to suppress the
>>> interactive password check.
>>>
>>> However, neither sudo 1.6.8p12 from MontaVista Linux 6 or 1.6.9p17
>>> from Ubuntu 9.04 supports the =A0-n option. The patch also removes the
>>> -n option from sudo calls. This option was added in 3/2008.
>>
>> Ugh. The sudo in gentoo did this though and that's the reason why I
>> added it in some scripts -- otherwise the pieces of junk halt waiting
>> for user input and I had manually kill the scripts >:(... I guess a
>> test will need to be added to ensure that sudo _does_ have the -n
>> option beforehand, if it does, add the -n option. Otherwise all people
>> running older versions are kind of SoL.
>>
>> sudo is still a non-standard tool and a pain in the butt to deal with
>> in scripts as it changes from time to time.
>>
>> FWIW your patch only deals with the case when the script `exits
>> cleanly' as there aren't any traps installed for cleanup_test.
>>
>>> On Fri, Apr 30, 2010 at 1:15 PM, Garrett Cooper <yanegomi@gmail.com> wr=
ote:
>>>> On Fri, Apr 30, 2010 at 12:27 PM, Henry Yei <hyei@mvista.com> wrote:
>>>>> Speaking of the utimesat test and prerequisites, our test systems
>>>>> don't have a sudoers file by default, so we have an internal patch to
>>>>> utimesat to create a default one if non exist and remove it after the
>>>>> test is done. Would that be of interest to LTP?
>>>>>>>
>> Thanks,
>> -Garrett
>>
>

>>>>> On Tue, Apr 27, 2010 at 11:27 PM, Caspar Zhang <casparant@gmail.com> =
wrote:
>>>>>> On Wed, Apr 28, 2010 at 2:04 PM, Garrett Cooper <yanegomi@gmail.com>=
 wrote:
>>>>>>> The first item is different from the other two. The first one ignor=
es the
>>>>>>> signal (SIG_IGN), whereas the latter two cases reset the handler to=
 the
>>>>>>> default one (SIG_DFL). I prefer the former format, because otherwis=
e the
>>>>>>> signal handlers become reentrable on accident.
>>>>>>
>>>>>> I see. Thank you.
>>>>>>
>>>>>> The final patch ;-)
>>>>
>>>> If it:
>>>>
>>>> 1. Works in all cases, i.e. doesn't use version specific constructs
>>>> for sudo (which I haven't seen thus far, but just to be safe).
>>>> 2. Is properly reverted when the test is done (which includes the
>>>> following scenarios):
>>>> =A0 =A0a. File already exists. Backup the old file, revert it when the
>>>> test is completed (regardless of whether or not the test passed or the
>>>> test failed properly [*]).
>>>> =A0 =A0b. File doesn't exist. Nuke the file after the test is done.
>>>>
>>>> =A0 =A0... sure.
>>>> Thanks,
>>>> -Garrett
>>>>
>>>> [*] SIGKILL or SIGSTOP can't be avoided, so technically it's a best ef=
fort.

--001485e988e4ce1f390488018d23
Content-Type: text/x-patch; charset=US-ASCII; name="utimensat_tests.patch"
Content-Disposition: attachment; filename="utimensat_tests.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9xg0fet1

LS0tIGx0cC1kZXYvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91dGltZW5zYXQvdXRpbWVuc2F0
X3Rlc3RzLnNoCTIwMTAtMDQtMzAgMTU6MzM6MTAuNzc5NzAwNDgzIC0wNzAwCisrKyBsdHAtZGV2
LXdkaXIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91dGltZW5zYXQvdXRpbWVuc2F0X3Rlc3Rz
LnNoCTIwMTAtMDUtMDMgMTk6NTM6NTIuMjcxNjk1Mjg5IC0wNzAwCkBAIC02NCwxMyArNjQsMTMg
QEAgc2V0dXBfZmlsZSgpCiAgICAgIyBNYWtlIHN1cmUgYW55IG9sZCB2ZXJzaW9uIG9mIGZpbGUg
aXMgZGVsZXRlZAogCiAgICAgaWYgdGVzdCAtZSAkRklMRTsgdGhlbgotICAgICAgICBzdWRvIC1u
IGNoYXR0ciAtYWkgJEZJTEUgfHwgcmV0dXJuICQ/Ci0gICAgICAgIHN1ZG8gLW4gcm0gLWYgJEZJ
TEUgfHwgcmV0dXJuICQ/CisgICAgICAgIHN1ZG8gJHNfYXJnIGNoYXR0ciAtYWkgJEZJTEUgfHwg
cmV0dXJuICQ/CisgICAgICAgIHN1ZG8gJHNfYXJnIHJtIC1mICRGSUxFIHx8IHJldHVybiAkPwog
ICAgIGZpCiAKICAgICAjIENyZWF0ZSBmaWxlIGFuZCBtYWtlIGF0aW1lIGFuZCBtdGltZSB6ZXJv
LgogCi0gICAgc3VkbyAtbiAtdSAkdXNlcl90ZXN0ZXIgdG91Y2ggJEZJTEUgfHwgcmV0dXJuICQ/
CisgICAgc3VkbyAkc19hcmcgLXUgJHVzZXJfdGVzdGVyIHRvdWNoICRGSUxFIHx8IHJldHVybiAk
PwogICAgIGlmICEgJFRFU1RfUFJPRyAtcSAkRklMRSAwIDAgMCAwID4gJFJFU1VMVF9GSUxFOyB0
aGVuCiAgICAgICAgIGVjaG8gIkZhaWxlZCB0byBzZXQgdXAgdGVzdCBmaWxlICRGSUxFIiAxPiYy
CiAgICAgICAgIGV4aXQgMQpAQCAtODYsMTkgKzg2LDE5IEBAIHNldHVwX2ZpbGUoKQogICAgICMg
U2V0IG93bmVyLCBwZXJtaXNzaW9ucywgYW5kIEVGQXMgZm9yIGZpbGUuCiAKICAgICBpZiB0ZXN0
IC1uICIkMiI7IHRoZW4KLSAgICAgICAgc3VkbyAtbiBjaG93biAkMiAkRklMRSB8fCByZXR1cm4g
JD8KKyAgICAgICAgc3VkbyAkc19hcmcgY2hvd24gJDIgJEZJTEUgfHwgcmV0dXJuICQ/CiAgICAg
ZmkKIAotICAgIHN1ZG8gLW4gY2htb2QgJDMgJEZJTEUgfHwgcmV0dXJuICQ/CisgICAgc3VkbyAk
c19hcmcgY2htb2QgJDMgJEZJTEUgfHwgcmV0dXJuICQ/CiAKICAgICBpZiB0ZXN0IC1uICIkNCI7
IHRoZW4KLSAgICAgICAgc3VkbyAtbiBjaGF0dHIgJDQgJEZJTEUgfHwgcmV0dXJuICQ/CisgICAg
ICAgIHN1ZG8gJHNfYXJnIGNoYXR0ciAkNCAkRklMRSB8fCByZXR1cm4gJD8KICAgICBmaQogCiAg
ICAgIyBEaXNwbGF5IGZpbGUgc2V0dXAsIGZvciB2aXN1YWwgdmVyaWZpY2F0aW9uCiAKICAgICBs
cyAtbCAkRklMRSB8IGF3ayAneyBwcmludGYgIk93bmVyPSVzOyBwZXJtcz0lczsgIiwgJDMsICQx
fScKLSAgICBpZiAhIHN1ZG8gLW4gbHNhdHRyIC1sICRGSUxFIHwgc2VkICdzLywgLywvZycgfCBh
d2sgJ3twcmludCAiRUZBcz0iICQyfScKKyAgICBpZiAhIHN1ZG8gJHNfYXJnIGxzYXR0ciAtbCAk
RklMRSB8IHNlZCAncy8sIC8sL2cnIHwgYXdrICd7cHJpbnQgIkVGQXM9IiAkMn0nCiAgICAgdGhl
bgogICAgICAgICByZXR1cm4gJD8KICAgICBmaQpAQCAtMjE1LDcgKzIxNSw3IEBAIHJ1bl90ZXN0
KCkKICAgICBjcCAkTFRQUk9PVC90ZXN0Y2FzZXMvYmluLyRURVNUX1BST0cgLi8KICAgICBDTUQ9
Ii4vJFRFU1RfUFJPRyAtcSAkRklMRSAkNCIKICAgICBlY2hvICIkQ01EIgotICAgIHN1ZG8gLW4g
LXUgJHVzZXJfdGVzdGVyICRDTUQgPiAkUkVTVUxUX0ZJTEUKKyAgICBzdWRvICRzX2FyZyAtdSAk
dXNlcl90ZXN0ZXIgJENNRCA+ICRSRVNVTFRfRklMRQogICAgIGNoZWNrX3Jlc3VsdCAkPyAkNSAk
NiAkNwogICAgIGVjaG8KIApAQCAtMjI0LDcgKzIyNCw3IEBAIHJ1bl90ZXN0KCkKICAgICAgICAg
c2V0dXBfZmlsZSAkRklMRSAiJDEiICIkMiIgIiQzIgogICAgICAgICBDTUQ9Ii4vJFRFU1RfUFJP
RyAtcSAtZCAkRklMRSBOVUxMICQ0IgogICAgICAgICBlY2hvICIkQ01EIgotICAgICAgICBzdWRv
IC1uIC11ICR1c2VyX3Rlc3RlciAkQ01EID4gJFJFU1VMVF9GSUxFCisgICAgICAgIHN1ZG8gJHNf
YXJnIC11ICR1c2VyX3Rlc3RlciAkQ01EID4gJFJFU1VMVF9GSUxFCiAgICAgICAgIGNoZWNrX3Jl
c3VsdCAkPyAkNSAkNiAkNwogICAgICAgICBlY2hvCiAgICAgZmkKQEAgLTIzNywxOCArMjM3LDQz
IEBAIHJ1bl90ZXN0KCkKICAgICAgICAgc2V0dXBfZmlsZSAkRklMRSAiJDEiICIkMiIgIiQzIgog
ICAgICAgICBDTUQ9Ii4vJFRFU1RfUFJPRyAtcSAtdyAtZCAkRklMRSBOVUxMICQ0IgogICAgICAg
ICBlY2hvICIkQ01EIgotICAgICAgICBzdWRvIC1uIC11ICR1c2VyX3Rlc3RlciAkQ01EID4gJFJF
U1VMVF9GSUxFCisgICAgICAgIHN1ZG8gJHNfYXJnIC11ICR1c2VyX3Rlc3RlciAkQ01EID4gJFJF
U1VMVF9GSUxFCiAgICAgICAgIGNoZWNrX3Jlc3VsdCAkPyAkNSAkNiAkNwogICAgICAgICBlY2hv
CiAgICAgZmkKIAotICAgIHN1ZG8gLW4gY2hhdHRyIC1haSAkRklMRQotICAgIHN1ZG8gLW4gcm0g
LWYgJEZJTEUKKyAgICBzdWRvICRzX2FyZyBjaGF0dHIgLWFpICRGSUxFCisgICAgc3VkbyAkc19h
cmcgcm0gLWYgJEZJTEUKK30KKworY2xlYW51cF90ZXN0KCkKK3sKKwlpZiB0ZXN0ICRzdWRvZXJz
X2NsZWFuOyB0aGVuCisJCXN1ZG8gcm0gLWYgJHN1ZG9lcnMKKwlmaQogfQogIz09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQogCiB1c2VyX3Rlc3Rlcj1ub2JvZHkKLXN1ZG8gLW4gLXUgJHVzZXJfdGVzdGVyIG1rZGlyIC1w
ICRURVNUX0RJUgorZWNobyAidGVzdCBzdWRvIGZvciAtbiBvcHRpb24sIG5vbi1pbnRlcmFjdGl2
ZSIKK3N1ZG8gLW4gdHJ1ZQoraWYgdGVzdCAkPyAtZXEgMDsgdGhlbgorCXNfYXJnPSItbiIKKwll
Y2hvICJzdWRvIHN1cHBvcnRzIC1uIgorZWxzZQorCXNfYXJnPQorCWVjaG8gInN1ZG8gZG9lcyBu
b3Qgc3VwcG9ydCAtbiIKK2ZpCitzdWRvZXJzPS9ldGMvc3Vkb2VycworaWYgdGVzdCAhIC1lICRz
dWRvZXJzCit0aGVuCisJZWNobyAicm9vdCAgICBBTEw9KEFMTCkgICAgQUxMIiA+ICRzdWRvZXJz
CisJc3Vkb2Vyc19jbGVhbj0xCisJY2htb2QgNDQwICRzdWRvZXJzCisJdHJhcCAndHJhcCAiIiBF
WElUOyBjbGVhbnVwX3Rlc3QnIEVYSVQKK2ZpCisKK3N1ZG8gJHNfYXJnIC11ICR1c2VyX3Rlc3Rl
ciBta2RpciAtcCAkVEVTVF9ESVIKIGNkICRURVNUX0RJUgogY2hvd24gcm9vdCAkTFRQUk9PVC90
ZXN0Y2FzZXMvYmluLyRURVNUX1BST0cKIGNobW9kIHVnbyt4LHUrcyAkTFRQUk9PVC90ZXN0Y2Fz
ZXMvYmluLyRURVNUX1BST0cK
--001485e988e4ce1f390488018d23
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------


--001485e988e4ce1f390488018d23
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001485e988e4ce1f390488018d23--

