Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1Ol6Yz-0008DV-1N
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 20:45:45 +0000
Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ol6Yy-00081Q-5W
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 20:45:45 +0000
Received: by qwi2 with SMTP id 2so398213qwi.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 16 Aug 2010 13:45:38 -0700 (PDT)
MIME-Version: 1.0
From: Henry Yei <hyei@mvista.com>
Date: Mon, 16 Aug 2010 13:45:18 -0700
Message-ID: <AANLkTinN_yVXA1FtbDmwPVf4S+m0OHKxH4SNiJmJx9Sh@mail.gmail.com>
Content-Type: multipart/mixed; boundary=0016363b87023ea909048df6ea62
Subject: [LTP] [PATCH] fix iogen01 test arguments to generate tmp files in
 TMPDIR in fs runtest file
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
To: ltp-list@lists.sourceforge.net

--0016363b87023ea909048df6ea62
Content-Type: text/plain; charset=ISO-8859-1

This patch updates the fs runtest file with arguments for the iogen01
test to honor the tmp directory set by runltp. Without this patch, the
tmp files are written to <ltp install dir>/testcases/bin.


Signed-off-by: Henry Yei <hyei@mvista.com>


Henry Yei <hyei@mvista.com>

--0016363b87023ea909048df6ea62
Content-Type: text/x-patch; charset=US-ASCII; name="fs.pn2.patch"
Content-Disposition: attachment; filename="fs.pn2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcxsgrg40

LS0tIGx0cC1kZXYvcnVudGVzdC9mcwkyMDEwLTA4LTAzIDE2OjQ5OjQ0Ljc0OTQ4MTQ4MiAtMDcw
MAorKysgbHRwLWRldi13ZGlyL3J1bnRlc3QvZnMJMjAxMC0wOC0xMyAxNDo1NjowNi45NjU5Nzky
NDIgLTA3MDAKQEAgLTM3LDcgKzM3LDcgQEAgcnd0ZXN0MDUgZXhwb3J0IExUUFJPT1Q7IHJ3dGVz
dCAtTiByd3RlcwogCiAjbXVzdCBiZSBydW4gYXMgcm9vdAogI2lvZ2VuMDEgaW9nZW4gLWkgMTIw
cyAtcyByZWFkLHdyaXRlIDUwMGI6ZG9pby5mMS4kJCAxMDAwYjpkb2lvLmYyLiQkIHwgZG9pbyAt
YWt2IC1uIDIKLWlvZ2VuMDEgZXhwb3J0IExUUFJPT1Q7IHJ3dGVzdCAtTiBpb2dlbjAxIC1pIDEy
MHMgLXMgcmVhZCx3cml0ZSAtRGEgLUR2IC1uIDIgNTAwYjpkb2lvLmYxLiQkIDEwMDBiOmRvaW8u
ZjIuJCQKK2lvZ2VuMDEgZXhwb3J0IExUUFJPT1Q7IHJ3dGVzdCAtTiBpb2dlbjAxIC1pIDEyMHMg
LXMgcmVhZCx3cml0ZSAtRGEgLUR2IC1uIDIgNTAwYjokVE1QRElSL2RvaW8uZjEuJCQgMTAwMGI6
JFRNUERJUi9kb2lvLmYyLiQkCiAKIGZzX2lub2QwMSBmc19pbm9kICRUTVAgMTAgMTAgMTAKIGxp
bmtlcjAxIGxpbmt0ZXN0LnNoIDEwMDAgMTAwMAo=
--0016363b87023ea909048df6ea62
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
--0016363b87023ea909048df6ea62
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016363b87023ea909048df6ea62--

