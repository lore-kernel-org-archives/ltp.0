Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xunwei.fan@bj.cs2c.com.cn>) id 1VtBaL-0007ul-DV
	for ltp-list@lists.sourceforge.net; Wed, 18 Dec 2013 07:30:25 +0000
Received: from regular2.263xmail.com ([211.157.152.3])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VtBaD-0002vm-JS
	for ltp-list@lists.sourceforge.net; Wed, 18 Dec 2013 07:30:25 +0000
Received: from regular1.263xmail.com (unknown [192.168.165.234])
	by regular2.263xmail.com (Postfix) with ESMTP id E9D51F3E4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 18 Dec 2013 15:12:24 +0800 (CST)
Received: from xunwei.fan?bj.cs2c.com.cn (unknown [192.168.165.27])
	by regular1.263xmail.com (Postfix) with SMTP id 41D25233E
	for <ltp-list@lists.sourceforge.net>;
	Wed, 18 Dec 2013 15:12:15 +0800 (CST)
Received: from wmthree-2 (localhost.localdomain [127.0.0.1])
	by smtpcom.263xmail.com (Postfix) with ESMTP id 0CC0B1B1D6
	for <ltp-list@lists.sourceforge.net>;
	Wed, 18 Dec 2013 15:12:13 +0800 (CST)
Date: Wed, 18 Dec 2013 15:12:16 +0800 (CST)
From: =?UTF-8?B?6IyD5YuL5Lyf?= <xunwei.fan@bj.cs2c.com.cn>
Message-ID: <1600529877.1004229.1387350736311.JavaMail.root@wmthree-2>
MIME-Version: 1.0
Subject: [LTP] =?utf-8?q?LTP_nfs_testcases_exportfs_problem?=
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7951874202854307453=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: =?UTF-8?B?bHRwLWxpc3Q=?= <ltp-list@lists.sourceforge.net>

--===============7951874202854307453==
Content-Type: text/html;  charset=utf-8
Content-Transfer-Encoding: base64

PHN0eWxlPnRhYmxlLmN1c3RvbVRhYmxlQ2xhc3NOYW1lIHttYXJnaW4tYm90dG9tOiAxMHB4O2Jv
cmRlci1jb2xsYXBzZTogY29sbGFwc2U7ZGlzcGxheTogdGFibGU7fS5jdXN0b21UYWJsZUNsYXNz
TmFtZSB0ZCwgLmN1c3RvbVRhYmxlQ2xhc3NOYW1lIHRoIHtib3JkZXI6IDFweCBzb2xpZCAjZGRk
O308L3N0eWxlPjxkaXYgaWQ9IndyaXRlLWN1c3RvbS13cml0ZSI+PHNwYW4gc3R5bGU9ImZvbnQt
ZmFtaWx5OiBhcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB4OyBjb2xvcjogcmdiKDM0
LCAzNCwgMzQpOyAgYmFja2dyb3VuZC1jb2xvcjogcmdiKDI1NSwgMjU1LCAyNTUpOyI+SGksPC9z
cGFuPjxiciBzdHlsZT0iY29sb3I6IHJnYigzNCwgMzQsIDM0KTsgZm9udC1mYW1pbHk6IGFyaWFs
LCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHg7IHdoaXRlLXNwYWNlOiBub3JtYWw7IGJhY2tn
cm91bmQtY29sb3I6IHJnYigyNTUsIDI1NSwgMjU1KTsiPjxwIHN0eWxlPSJmb250LWZhbWlseTog
5a6L5L2TOyBmb250LXNpemU6IDE2cHg7Ij48c3BhbiBzdHlsZT0iY29sb3I6IHJnYigzNCwgMzQs
IDM0KTsgZm9udC1mYW1pbHk6IGFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEycHg7ICBi
YWNrZ3JvdW5kLWNvbG9yOiByZ2IoMjU1LCAyNTUsIDI1NSk7Ij5XZSBhcmUgdXNpbmcgTFRQICJs
dHAtZnVsbC0yMDEzMDkwNCIgb24gRmVkb3JhIDIwLlRoZSBuZnMgdGVzdGNhc2VzIGFyZSBmYWls
aW5nLjwvc3Bhbj48L3A+PHAgc3R5bGU9ImZvbnQtZmFtaWx5OiDlrovkvZM7IGZvbnQtc2l6ZTog
MTZweDsiPjxzcGFuIHN0eWxlPSJjb2xvcjogcmdiKDM0LCAzNCwgMzQpOyBmb250LWZhbWlseTog
YXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJweDsgIGJhY2tncm91bmQtY29sb3I6IHJn
YigyNTUsIDI1NSwgMjU1KTsiPldlIGdvdCB0aGUgc2FtZSBlcnJvcnM6PC9zcGFuPjwvcD48cCBz
dHlsZT0iZm9udC1mYW1pbHk6IOWui+S9kzsgZm9udC1zaXplOiAxNnB4OyI+PHNwYW4gc3R5bGU9
ImZvbnQtZmFtaWx5OiBhcmlhbCwgaGVsdmV0aWNhLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDEy
cHg7Ij5leHBvcnRmczogL3RtcC9uZnN4eHh4eHgudGVzdGRpciByZXF1aXJlcyBmc2lkPSBmb3Ig
TkZTIGV4cG9ydDwvc3Bhbj48L3A+PHAgc3R5bGU9ImZvbnQtZmFtaWx5OiDlrovkvZM7IGZvbnQt
c2l6ZTogMTZweDsiPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTogYXJpYWwsIGhlbHZldGljYSwg
c2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB4OyI+VGhlIGRlZmF1bHQgbW91bnQgdHlwZSBvZiAv
dG1wIGlzIHRtcGZzIG9uIEZlZG9yYSAyMC4gSXQgc2VlbXMgdGhhdCBmc2lkIG11c3QgYmUgc2V0
IGluIGV4cG9ydGZzIG9wdGlvbnMuPC9zcGFuPjwvcD48cCBzdHlsZT0iZm9udC1mYW1pbHk6IOWu
i+S9kzsgZm9udC1zaXplOiAxNnB4OyI+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMzQsIDM0LCAz
NCk7IGZvbnQtZmFtaWx5OiBhcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB4OyB3aGl0
ZS1zcGFjZTogbm9ybWFsOyBiYWNrZ3JvdW5kLWNvbG9yOiByZ2IoMjU1LCAyNTUsIDI1NSk7Ij5B
bnkgdGhvdWdodHM/PC9zcGFuPjxicj48L3A+PHAgc3R5bGU9ImZvbnQtZmFtaWx5OiDlrovkvZM7
IGZvbnQtc2l6ZTogMTZweDsiPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTogYXJpYWwsIGhlbHZl
dGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxMnB4OyI+PGJyPjwvc3Bhbj48L3A+PHAgc3R5
bGU9ImZvbnQtc2l6ZTogMTZweDsiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6IDEycHg7IGJhY2tn
cm91bmQtY29sb3I6IHJnYigyNTUsIDI1NSwgMjU1KTsiPjxmb250IGNvbG9yPSIjMjIyMjIyIiBm
YWNlPSJhcmlhbCwgc2Fucy1zZXJpZiI+VGhhbmtzLDwvZm9udD48L3NwYW4+PC9wPjxwIHN0eWxl
PSJmb250LXNpemU6IDE2cHg7Ij48c3BhbiBzdHlsZT0iZm9udC1zaXplOiAxMnB4OyBiYWNrZ3Jv
dW5kLWNvbG9yOiByZ2IoMjU1LCAyNTUsIDI1NSk7Ij48Zm9udCBjb2xvcj0iIzIyMjIyMiIgZmFj
ZT0iYXJpYWwsIHNhbnMtc2VyaWYiPlh1bndlaSBGYW48L2ZvbnQ+PC9zcGFuPjwvcD48L2Rpdj4=



--===============7951874202854307453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
--===============7951874202854307453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7951874202854307453==--
