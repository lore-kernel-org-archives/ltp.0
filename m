Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1O7zcc-0007Zk-2I
	for ltp-list@lists.sourceforge.net; Fri, 30 Apr 2010 23:27:50 +0000
Received: from mail-qy0-f189.google.com ([209.85.221.189])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O7zcb-0003od-3E
	for ltp-list@lists.sourceforge.net; Fri, 30 Apr 2010 23:27:50 +0000
MIME-Version: 1.0
In-Reply-To: <x2l364299f41004301315x20fa3ed6u488dc923334fd5d6@mail.gmail.com>
References: <103530624.1121001272433642504.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<8B8139E0-F07A-433D-B38D-30DAB81E3FF5@gmail.com>
	<s2r700385ec1004272327n8b26491bt3609f8877b71a385@mail.gmail.com>
	<m2z42aa607e1004301227tfec6a200kda741f32b6feeb11@mail.gmail.com> 
	<x2l364299f41004301315x20fa3ed6u488dc923334fd5d6@mail.gmail.com>
From: Henry Yei <hyei@mvista.com>
Date: Fri, 30 Apr 2010 15:56:41 -0700
Message-ID: <q2w42aa607e1004301556s76e89e8nf68d4bee860da4bd@mail.gmail.com>
Content-Type: multipart/mixed; boundary=0016364ee3083e453f04857c291a
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

--0016364ee3083e453f04857c291a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

If a sudo file exists, the patch doesn't touch it. If it does not, a
sudoers file will be created and then it will remove it afterwards. I
wouldn't feel confortable having a script modify a sudoers file if it
already exists. The sudoers content that it does put in place just
enables the root user to use sudo, which would not give it any more
access than it already has. This text is available in every sudoers
file I've looked at.



While I was testing the patch with the ltp-dev branch, I noticed that
the -n option was put in front of every sudo call in commit
2aa40f7e10518977881b933cc93b8f50847cf3cf in order to suppress the
interactive password check.

However, neither sudo 1.6.8p12 from MontaVista Linux 6 or 1.6.9p17
from Ubuntu 9.04 supports the  -n option. The patch also removes the
-n option from sudo calls. This option was added in 3/2008.

Signed-Off-By: <hyei@mvista.com>


On Fri, Apr 30, 2010 at 1:15 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Fri, Apr 30, 2010 at 12:27 PM, Henry Yei <hyei@mvista.com> wrote:
>> Speaking of the utimesat test and prerequisites, our test systems
>> don't have a sudoers file by default, so we have an internal patch to
>> utimesat to create a default one if non exist and remove it after the
>> test is done. Would that be of interest to LTP?
>>
>> On Tue, Apr 27, 2010 at 11:27 PM, Caspar Zhang <casparant@gmail.com> wro=
te:
>>> On Wed, Apr 28, 2010 at 2:04 PM, Garrett Cooper <yanegomi@gmail.com> wr=
ote:
>>>> The first item is different from the other two. The first one ignores =
the
>>>> signal (SIG_IGN), whereas the latter two cases reset the handler to th=
e
>>>> default one (SIG_DFL). I prefer the former format, because otherwise t=
he
>>>> signal handlers become reentrable on accident.
>>>
>>> I see. Thank you.
>>>
>>> The final patch ;-)
>
> If it:
>
> 1. Works in all cases, i.e. doesn't use version specific constructs
> for sudo (which I haven't seen thus far, but just to be safe).
> 2. Is properly reverted when the test is done (which includes the
> following scenarios):
> =A0 =A0a. File already exists. Backup the old file, revert it when the
> test is completed (regardless of whether or not the test passed or the
> test failed properly [*]).
> =A0 =A0b. File doesn't exist. Nuke the file after the test is done.
>
> =A0 =A0... sure.
> Thanks,
> -Garrett
>
> [*] SIGKILL or SIGSTOP can't be avoided, so technically it's a best effor=
t.
>

--0016364ee3083e453f04857c291a
Content-Type: text/x-patch; charset=US-ASCII; name="utimensat_tests.patch"
Content-Disposition: attachment; filename="utimensat_tests.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g8nlido60

LS0tIGx0cC1kZXYvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91dGltZW5zYXQvdXRpbWVuc2F0
X3Rlc3RzLnNoCTIwMTAtMDQtMzAgMTU6MzM6MTAuNzc5NzAwNDgzIC0wNzAwCisrKyBsdHAtZGV2
LXdkaXIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91dGltZW5zYXQvdXRpbWVuc2F0X3Rlc3Rz
LnNoCTIwMTAtMDQtMzAgMTU6NDc6MDguMjA3Njk2MDQwIC0wNzAwCkBAIC02NCw0MSArNjQsNDEg
QEAgc2V0dXBfZmlsZSgpCiAgICAgIyBNYWtlIHN1cmUgYW55IG9sZCB2ZXJzaW9uIG9mIGZpbGUg
aXMgZGVsZXRlZAogCiAgICAgaWYgdGVzdCAtZSAkRklMRTsgdGhlbgotICAgICAgICBzdWRvIC1u
IGNoYXR0ciAtYWkgJEZJTEUgfHwgcmV0dXJuICQ/Ci0gICAgICAgIHN1ZG8gLW4gcm0gLWYgJEZJ
TEUgfHwgcmV0dXJuICQ/CisgICAgICAgIHN1ZG8gY2hhdHRyIC1haSAkRklMRSB8fCByZXR1cm4g
JD8KKyAgICAgICAgc3VkbyBybSAtZiAkRklMRSB8fCByZXR1cm4gJD8KICAgICBmaQogCiAgICAg
IyBDcmVhdGUgZmlsZSBhbmQgbWFrZSBhdGltZSBhbmQgbXRpbWUgemVyby4KIAotICAgIHN1ZG8g
LW4gLXUgJHVzZXJfdGVzdGVyIHRvdWNoICRGSUxFIHx8IHJldHVybiAkPworICAgIHN1ZG8gLXUg
JHVzZXJfdGVzdGVyIHRvdWNoICRGSUxFIHx8IHJldHVybiAkPwogICAgIGlmICEgJFRFU1RfUFJP
RyAtcSAkRklMRSAwIDAgMCAwID4gJFJFU1VMVF9GSUxFOyB0aGVuCiAgICAgICAgIGVjaG8gIkZh
aWxlZCB0byBzZXQgdXAgdGVzdCBmaWxlICRGSUxFIiAxPiYyCi0gICAgICAgIGV4aXQgMQorICAg
ICAgICBjbGVhbnVwX3Rlc3QKICAgICBmaQogCiAgICAgcmVhZCByZXMgYXRpbWUgbXRpbWUgPCAk
UkVTVUxUX0ZJTEUKICAgICBpZiB0ZXN0ICJYJHJlcyIgIT0gIlhTVUNDRVNTIiB8fAogICAgICAg
ICAgICAgICAgIHRlc3QgJGF0aW1lIC1uZSAwIHx8IHRlc3QgJG10aW1lICE9IDA7IHRoZW4KICAg
ICAgICAgZWNobyAiRmFpbGVkIHRvIHNldCBjb3JyZWN0IHRpbWVzIG9uIHRlc3QgZmlsZSAkRklM
RSIgMT4mMgotICAgICAgICBleGl0IDEKKyAgICAgICAgY2xlYW51cF90ZXN0CiAgICAgZmkKIAog
ICAgICMgU2V0IG93bmVyLCBwZXJtaXNzaW9ucywgYW5kIEVGQXMgZm9yIGZpbGUuCiAKICAgICBp
ZiB0ZXN0IC1uICIkMiI7IHRoZW4KLSAgICAgICAgc3VkbyAtbiBjaG93biAkMiAkRklMRSB8fCBy
ZXR1cm4gJD8KKyAgICAgICAgc3VkbyBjaG93biAkMiAkRklMRSB8fCByZXR1cm4gJD8KICAgICBm
aQogCi0gICAgc3VkbyAtbiBjaG1vZCAkMyAkRklMRSB8fCByZXR1cm4gJD8KKyAgICBzdWRvIGNo
bW9kICQzICRGSUxFIHx8IHJldHVybiAkPwogCiAgICAgaWYgdGVzdCAtbiAiJDQiOyB0aGVuCi0g
ICAgICAgIHN1ZG8gLW4gY2hhdHRyICQ0ICRGSUxFIHx8IHJldHVybiAkPworICAgICAgICBzdWRv
IGNoYXR0ciAkNCAkRklMRSB8fCByZXR1cm4gJD8KICAgICBmaQogCiAgICAgIyBEaXNwbGF5IGZp
bGUgc2V0dXAsIGZvciB2aXN1YWwgdmVyaWZpY2F0aW9uCiAKICAgICBscyAtbCAkRklMRSB8IGF3
ayAneyBwcmludGYgIk93bmVyPSVzOyBwZXJtcz0lczsgIiwgJDMsICQxfScKLSAgICBpZiAhIHN1
ZG8gLW4gbHNhdHRyIC1sICRGSUxFIHwgc2VkICdzLywgLywvZycgfCBhd2sgJ3twcmludCAiRUZB
cz0iICQyfScKKyAgICBpZiAhIHN1ZG8gbHNhdHRyIC1sICRGSUxFIHwgc2VkICdzLywgLywvZycg
fCBhd2sgJ3twcmludCAiRUZBcz0iICQyfScKICAgICB0aGVuCiAgICAgICAgIHJldHVybiAkPwog
ICAgIGZpCkBAIC0xMjYsNyArMTI2LDcgQEAgY2hlY2tfcmVzdWx0KCkKIAogICAgIGlmIHRlc3Qg
JFNUQVRVUyAtZ3QgMTsgdGhlbgogICAgICAgICBlY2hvICJGQUlMRUQgKGJhZCB0ZXN0IHNldHVw
KSIKLSAgICAgICAgZXhpdCAxCisgICAgICAgIGNsZWFudXBfdGVzdAogICAgIGZpCiAKICAgICBy
ZWFkIHJlcyBhdGltZSBtdGltZSA8ICRSRVNVTFRfRklMRQpAQCAtMjA0LDcgKzIwNCw3IEBAIHJ1
bl90ZXN0KCkKICAgICAgICAgVykgZG9fd3JpdGVfZmRfdGVzdD0wCiAgICAgICAgICAgIDs7CiAg
ICAgICAgICopIGVjaG8gInJ1bl90ZXN0OiBiYWQgdXNhZ2UiCi0gICAgICAgICAgIGV4aXQgMQor
ICAgICAgICAgICBjbGVhbnVwX3Rlc3QKICAgICAgICAgICAgOzsKICAgICAgICAgZXNhYwogICAg
IGRvbmUKQEAgLTIxNSw3ICsyMTUsNyBAQCBydW5fdGVzdCgpCiAgICAgY3AgJExUUFJPT1QvdGVz
dGNhc2VzL2Jpbi8kVEVTVF9QUk9HIC4vCiAgICAgQ01EPSIuLyRURVNUX1BST0cgLXEgJEZJTEUg
JDQiCiAgICAgZWNobyAiJENNRCIKLSAgICBzdWRvIC1uIC11ICR1c2VyX3Rlc3RlciAkQ01EID4g
JFJFU1VMVF9GSUxFCisgICAgc3VkbyAtdSAkdXNlcl90ZXN0ZXIgJENNRCA+ICRSRVNVTFRfRklM
RQogICAgIGNoZWNrX3Jlc3VsdCAkPyAkNSAkNiAkNwogICAgIGVjaG8KIApAQCAtMjI0LDcgKzIy
NCw3IEBAIHJ1bl90ZXN0KCkKICAgICAgICAgc2V0dXBfZmlsZSAkRklMRSAiJDEiICIkMiIgIiQz
IgogICAgICAgICBDTUQ9Ii4vJFRFU1RfUFJPRyAtcSAtZCAkRklMRSBOVUxMICQ0IgogICAgICAg
ICBlY2hvICIkQ01EIgotICAgICAgICBzdWRvIC1uIC11ICR1c2VyX3Rlc3RlciAkQ01EID4gJFJF
U1VMVF9GSUxFCisgICAgICAgIHN1ZG8gLXUgJHVzZXJfdGVzdGVyICRDTUQgPiAkUkVTVUxUX0ZJ
TEUKICAgICAgICAgY2hlY2tfcmVzdWx0ICQ/ICQ1ICQ2ICQ3CiAgICAgICAgIGVjaG8KICAgICBm
aQpAQCAtMjM3LDE4ICsyMzcsMzMgQEAgcnVuX3Rlc3QoKQogICAgICAgICBzZXR1cF9maWxlICRG
SUxFICIkMSIgIiQyIiAiJDMiCiAgICAgICAgIENNRD0iLi8kVEVTVF9QUk9HIC1xIC13IC1kICRG
SUxFIE5VTEwgJDQiCiAgICAgICAgIGVjaG8gIiRDTUQiCi0gICAgICAgIHN1ZG8gLW4gLXUgJHVz
ZXJfdGVzdGVyICRDTUQgPiAkUkVTVUxUX0ZJTEUKKyAgICAgICAgc3VkbyAtdSAkdXNlcl90ZXN0
ZXIgJENNRCA+ICRSRVNVTFRfRklMRQogICAgICAgICBjaGVja19yZXN1bHQgJD8gJDUgJDYgJDcK
ICAgICAgICAgZWNobwogICAgIGZpCiAKLSAgICBzdWRvIC1uIGNoYXR0ciAtYWkgJEZJTEUKLSAg
ICBzdWRvIC1uIHJtIC1mICRGSUxFCisgICAgc3VkbyBjaGF0dHIgLWFpICRGSUxFCisgICAgc3Vk
byBybSAtZiAkRklMRQorfQorCitjbGVhbnVwX3Rlc3QoKQoreworCWlmIHRlc3QgJHN1ZG9lcnNf
Y2xlYW4KKwl0aGVuCisJCXN1ZG8gcm0gLWYgJHN1ZG9lcnMKKwlmaQogfQogIz09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQogCiB1c2VyX3Rlc3Rlcj1ub2JvZHkKLXN1ZG8gLW4gLXUgJHVzZXJfdGVzdGVyIG1rZGlyIC1w
ICRURVNUX0RJUgorc3Vkb2Vycz0vZXRjL3N1ZG9lcnMKK2lmIHRlc3QgISAtZSAkc3Vkb2Vycwor
dGhlbgorCWVjaG8gInJvb3QgICAgQUxMPShBTEwpICAgIEFMTCIgPiAkc3Vkb2VycworCXN1ZG9l
cnNfY2xlYW49MQorCWNobW9kIDQ0MCAkc3Vkb2VycworZmkKK3N1ZG8gLXUgJHVzZXJfdGVzdGVy
IG1rZGlyIC1wICRURVNUX0RJUgogY2QgJFRFU1RfRElSCiBjaG93biByb290ICRMVFBST09UL3Rl
c3RjYXNlcy9iaW4vJFRFU1RfUFJPRwogY2htb2QgdWdvK3gsdStzICRMVFBST09UL3Rlc3RjYXNl
cy9iaW4vJFRFU1RfUFJPRwpAQCAtNDM3LDYgKzQ1Miw3IEBAIGVjaG8gIj09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KIAogZWNobwogCitjbGVhbnVwX3Rlc3QKIHJtIC1yZiAiJFRF
U1RfRElSIgogdW5hbWUgLWEKIGRhdGUK
--0016364ee3083e453f04857c291a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0016364ee3083e453f04857c291a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016364ee3083e453f04857c291a--

