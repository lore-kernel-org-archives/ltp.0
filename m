Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <anthony.ton@ericsson.com>) id 1Ntoq2-0007kq-4G
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 21:07:06 +0000
Received: from imr1.ericy.com ([198.24.6.9])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ntoq0-0000EY-Dx
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 21:07:06 +0000
From: Anthony Ton <anthony.ton@ericsson.com>
Date: Mon, 22 Mar 2010 17:06:54 -0400
Message-ID: <E0B6230F32558E43951AF1B0DEBF98102119D21AFB@EUSAACMS0714.eamcs.ericsson.se>
References: <E0B6230F32558E43951AF1B0DEBF98102119D20EDD@EUSAACMS0714.eamcs.ericsson.se>
	<20100322064157.GB20606@linux.vnet.ibm.com>
In-Reply-To: <20100322064157.GB20606@linux.vnet.ibm.com>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_E0B6230F32558E43951AF1B0DEBF98102119D21AFBEUSAACMS0714e_"
MIME-Version: 1.0
Subject: Re: [LTP] tcore.exp
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
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--_002_E0B6230F32558E43951AF1B0DEBF98102119D21AFBEUSAACMS0714e_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Rishikesh,
See the attached file.
Regards,
Anthony

-----Original Message-----
From: Rishikesh K Rajak [mailto:risrajak@linux.vnet.ibm.com]=20
Sent: Sunday, March 21, 2010 11:42 PM
To: Anthony Ton
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] tcore.exp

>It appears that the proc check_fpu in tcore.exp has an error when the=20
>expect can't \ find the expected string "xmm$num ...".  In the timeout=20
>block, the code read
>
>fail "fail to check the xmm value(timeout)"
>
>In my humble opinion, it should be
>
>send_user "fail to check the xmm value(timeout)"

Hi Anthony,

Send us a patch with the correct changes and then someone can review here.

--
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

--_002_E0B6230F32558E43951AF1B0DEBF98102119D21AFBEUSAACMS0714e_
Content-Type: application/octet-stream; name="tcore.exp"
Content-Description: tcore.exp
Content-Disposition: attachment; filename="tcore.exp"; size=3847;
	creation-date="Mon, 22 Mar 2010 17:05:14 GMT";
	modification-date="Mon, 22 Mar 2010 17:05:14 GMT"
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9leHBlY3QgLS0KCiMgICAgQ29weXJpZ2h0IChjKSBHdW8gTWluIDxtaW4uZ3Vv
QGludGVsLmNvbT4uLCAyMDAyCiMKIyAgICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsg
IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKIyAgICBpdCB1bmRlciB0aGUg
dGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQoj
ICAgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhl
IExpY2Vuc2UsIG9yCiMgICAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KIwoj
ICAgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwg
YmUgdXNlZnVsLAojICAgIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgIHdpdGhvdXQgZXZlbiB0
aGUgaW1wbGllZCB3YXJyYW50eSBvZgojICAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZP
UiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZQojICAgIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgojCiMgICAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVk
IGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKIyAgICBhbG9uZyB3aXRo
IHRoaXMgcHJvZ3JhbTsgIGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUKIyAgICBG
b3VuZGF0aW9uLCBJbmMuLCA1OSBUZW1wbGUgUGxhY2UsIFN1aXRlIDMzMCwgQm9zdG9uLCBNQSAw
MjExMS0xMzA3IFVTQQoKc2V0IGN1cnJfdGhyZWFkIDAgCnNldCBwYXNzIDAKcHJvYyBjaGVja19i
dWYge2J1ZiBrZXl9IHsKICAgIHNldCBudW0gMAogICAgZm9yIHt9IDEge30gewoJc2V0IHNwbGl0
X2J1ZiBbc3BsaXQgJGJ1ZiAiIl0KCXNldCBpIFtzdHJpbmcgZmlyc3QgIlxuIiAkYnVmXQoJaWYg
JGk9PS0xIGJyZWFrOwogICAJc2V0IGxpbmUgW2pvaW4gW2xyYW5nZSAkc3BsaXRfYnVmIDAgJGld
ICIiXQogIAlzZXQgYnVmIFtqb2luIFtscmFuZ2UgJHNwbGl0X2J1ZiBbZXhwciAxKyRpXSBlbmRd
ICIiXQoJc2V0IGkgW2xzZWFyY2ggJGxpbmUgJGtleV0KCWlmIC0xIT0kaSB7CgkJaW5jciBudW0K
CX0KICAgIH0KCXJldHVybiAkbnVtCn0KcHJvYyBjaGVja190aHJlYWRzIHt9IHsKICAgIGdsb2Jh
bCBjdXJyX3RocmVhZAogICAgZ2xvYmFsIHBhc3MKICAgIHNldCBpc3RydWUgMCAKICAgIHNlbmQg
ImluZm8gdGhyZWFkc1xuIgogICAgZXhwZWN0IHsKICAgICAgIAktcmUgIiBcWzAtOVxdKyBwcm9j
ZXNzIC4qKGdkYikiIHsKCXNldCBidWYgJGV4cGVjdF9vdXQoMCxzdHJpbmcpCiAgICAJfQoJdGlt
ZW91dCB7CgkJZmFpbCAidGltZW91dCB3aGlsZSAgcnVuIGluZm8gdGhyZWFkcyIKCQlyZXR1cm4g
MQoJfQogICAgfQogICAgc2V0IGN1cnJfdGhyZWFkIFtjaGVja19idWYgJGJ1ZiAicHJvY2VzcyJd
CiAgICBpZiB7ICRjdXJyX3RocmVhZCA9PSAwIH0gewoJc2VuZF91c2VyICJjaGVja190aHJlYWRz
IChubyBjdXJyZW50IHRocmVhZClcbiIKCXJldHVybiAxCiAgICB9CiAgICBpZiB7ICRjdXJyX3Ro
cmVhZCA+PSAxIH0gewoJc2V0IHBhc3MgW2V4cHIgJHBhc3MgKyAxXQoJc2VuZF91c2VyICJ0aGUg
Y29yZSBkdW1wIGluY2x1ZGVzIG11bHRpIHRocmVhZCBpbmZvcm1hdGlvblxuIgoJcmV0dXJuIDAK
ICAgIH0KfQoKcHJvYyBjaGVja19idCB7fSB7CglnbG9iYWwgY3Vycl90aHJlYWQKCWdsb2JhbCBw
YXNzCglzZXQgdGVzdCAwCiAgICAgICAgc2V0IGNvdW50ZXIgMQogICAgICAgIHdoaWxlIHsgJGNv
dW50ZXIgPD0gJGN1cnJfdGhyZWFkIH0gIHsKICAgICAgICAgICAgICAgIHNlbmQgIlxuIgogICAg
ICAgICAgICAgICAgc2VuZCAidGhyZWFkICRjb3VudGVyXG4iCiAgICAgICAgICAgICAgICBleHBl
Y3QgewogICAgICAgICAgICAgICAgICAgICAgICAtcmUgIlN3aXRjaGluZyB0byB0aHJlYWQgJGNv
dW50ZXIgLipcbiIgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNldCBidWYgJGV4
cGVjdF9vdXQoMCxzdHJpbmcpCiAgICAgICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAg
ICAgICAgICAgICAgdGltZW91dCB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNl
bmRfdXNlciAidGltZW91dCAiOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gMQogICAgICAgICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgICAgICB9CiAgICAgICAg
ICAgICAgICBzZXQgbnVtYmVyMSBbY2hlY2tfYnVmICRidWYgIihwcm9jZXNzIl0KICAgICAgICAg
ICAgICAgIHNlbmQgImJ0XG4iCiAgICAgICAgICAgICAgICBleHBlY3QgewogICAgICAgICAgICAg
ICAgICAgICAgICAtcmUgICIgYnQuKiNcWzAtOVxdKyAuKihnZGIpIiB7CiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc2V0IGJ1ZiAkZXhwZWN0X291dCgwLHN0cmluZykKCQkgICAgICAg
ICAgICAgfQogICAgICAgICAgICAgICAgfQogICAgICAgICAgICAgICAgc2V0IG51bWJlciBbY2hl
Y2tfYnVmICRidWYgImluIl0KICAgICAgICAgICAgICAgIGlmIHsgICRudW1iZXIgPCAxICB9IHsK
CQkJc2V0IHRlc3QgMQoJICAgICAgICB9IAogICAgICAgICAgICAgICAgc2V0IGNvdW50ZXIgW2V4
cHIgJGNvdW50ZXIgKyAxXQogICAgICAgIH0KCWlmIHsgMCA9PSAkdGVzdCB9IHsKCQlzZXQgcGFz
cyBbZXhwciAkcGFzcyArIDFdCgkJc2VuZF91c2VyICJjaGVjayBidCBpbiBjb3JlZHVtcCBzdWNj
ZXNzZnVsbHkiCgkJcmV0dXJuIDAKCX0gZWxzZSB7CgkJc2VuZF91c2VyICAiY2hlY2sgYnQgaW4g
Y29yZWR1bXAgaW5jb3JyZWN0bHkiCgkJcmV0dXJuIDEKCX0KICAgICAgICByZXR1cm4gMAp9Cgpw
cm9jIGNoZWNrX2ZwdSB7bnVtfSB7CglnbG9iYWwgZXhwZWN0X291dAoJZ2xvYmFsIHBhc3MKCXNl
bmQgIlxuIgoJc2VuZCAiaW5mbyByZWdpc3RlclxuIgoJc2VuZCAiXG4iCglleHBlY3QgeyAKCQkt
cmUgInhtbSRudW1cW1x0IFxdK1x7ZiBcPSAuKlx9K1xbXHQgXF0rXHtmIFw9IC4qXH0iIHsKCQkJ
c2V0IGJ1ZiAkZXhwZWN0X291dCgwLHN0cmluZykKCQl9CgkJdGltZW91dCB7CgkgICAgICAgICAg
ICBzZW5kX3VzZXIgImZhaWwgdG8gY2hlY2sgdGhlIHhtbSB2YWx1ZSh0aW1lb3V0KSIKICAgICAg
ICAJICAgIHJldHVybiAxCiAgICAgICAgCX0KCX0KCXNlbmQgInF1aXRcbiIKCXNldCBidWZfdG1w
IFtzcGxpdCAkYnVmICJceyJdCglzZXQgYnVmMSBbbGluZGV4ICRidWZfdG1wIDRdCglzZXQgYnVm
MiBbc3BsaXQgJGJ1ZjEgIiwiXQoJc2V0IG51bWJlciBbbGluZGV4ICRidWYyIDFdCglpZiB7IDAg
IT0gJG51bWJlciB9IHsKCQlzZXQgcGFzcyBbZXhwciAkcGFzcyArIDFdCgkJc2VuZF91c2VyICJz
dWNjZXNzIHdoaWxlIGNoZWNrIHdoZXRoZXIgY29yZSBkdW1wIGluY2x1ZGVzIGZwdSBpbmZvcm1h
dGlvbiIJCgkJcmV0dXJuIDAKCX0gZWxzZSB7CgkJc2VuZF91c2VyICJmYWlsIHdoaWxlIGNoZWNr
IHdoZXRoZXIgY29yZSBkdW1wIGluY2x1ZGVzIGZwdSBpbmZvcm1hdGlvbiIKCQlyZXR1cm4gMQoJ
fQp9CnNldCBHREIgZ2RiCnNldCBiaW5maWxlIC4vdGNvcmUKc2V0IGNvcmVmaWxlICAuL2NvcmVm
aWxlCgpzcGF3biAkR0RCICR7YmluZmlsZX0gJHtjb3JlZmlsZX0KY2hlY2tfZnB1IDUKc2VuZCAi
cXVpdFxuIgoKc3Bhd24gJEdEQiAke2JpbmZpbGV9ICR7Y29yZWZpbGV9CmNoZWNrX3RocmVhZHMK
c2VuZCAicXVpdFxuIgoKCnNwYXduICRHREIgJHtiaW5maWxlfSAke2NvcmVmaWxlfQpjaGVja19i
dApzZW5kICJxdWl0XG4iCmV4aXQgJHBhc3MKCg==

--_002_E0B6230F32558E43951AF1B0DEBF98102119D21AFBEUSAACMS0714e_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--_002_E0B6230F32558E43951AF1B0DEBF98102119D21AFBEUSAACMS0714e_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--_002_E0B6230F32558E43951AF1B0DEBF98102119D21AFBEUSAACMS0714e_--

