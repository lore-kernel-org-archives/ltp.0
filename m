Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B0606A320
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 14:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dzsKd1gh
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3C4D3EA9B3
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 15:26:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A1B93E1B27
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 15:11:28 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 38D201400180
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 15:11:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795097488; x=1826633488;
 h=date:from:to:cc:subject:message-id:mime-version:
 content-transfer-encoding:in-reply-to;
 bh=nw7rQPipSkhtV/UQgw2LJ0rMDn1dGG0TaB4g5lNPeio=;
 b=dzsKd1ghwRNpNeyF+vmeeDf6lJtmItEVTNEKC3dYWBePN46Er5W2cyZq
 KTEpIrXO49jXBubZYDuGRfNHqRLHRE5HionnsOrIAIXRjdhUFalBZ1Izi
 rK3VUhv4AfC1aoR8QXNMUfaweVMdGiq/c87+DpoHaaa+hQHUXdd12xGZL
 2Wbx5eyMRRvjlMuMqQEdkp8RhBW4byflVF/E7ST+8IiV7NhIQ87ImJTdq
 jZUQVnWYNZxREu2rPdXnugVb3k72V9ZLngXzk4JItKYfiU2jWxcWjH26Y
 Kk5o1JG1bMEfPJ5IfMcq5KX85jybNsiIRJ72iPjjsh1ZhCGxWEkBtJtEU w==;
X-CSE-ConnectionGUID: 3mCN3wnwQFaM63j4Lh1g6g==
X-CSE-MsgGUID: XXcaZJC+RViN/BUJ/CK84A==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3954961"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3954961"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 06:11:23 -0800
X-CSE-ConnectionGUID: Y7htxKcIQZqpqFq6wYNJhw==
X-CSE-MsgGUID: FDK0PtvFRbC2gRpIiTQ4jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; d="scan'208";a="10573856"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation)
 ([10.239.182.64])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 06:11:13 -0800
Date: Thu, 19 Nov 2026 22:11:10 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <202611192004.cca8bf73-lkp@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261113-sched_dl-v3-6-a76ffa1cdeee@linutronix.de>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 19 Nov 2026 15:26:43 +0100
Subject: Re: [LTP] [PATCH v3 6/8] sched: Limit sysctl
 sched_rt_{period|runtime}_us to RT_GROUP_SCHED
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Ben Segall <bsegall@google.com>,
 John Ogness <john.ogness@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Vincent Guittot <vincent.guittot@linaro.org>, yu.c.chen@intel.com,
 Jonathan Corbet <corbet@lwn.net>, luca abeni <luca.abeni@santannapisa.it>,
 aubrey.li@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Boqun Feng <boqun@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, yi1.lai@intel.com,
 Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>,
 rcu@vger.kernel.org, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, ltp@lists.linux.it, lkp@intel.com,
 Zqiang <qiang.zhang@linux.dev>, Joel Fernandes <joelagnelf@nvidia.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Yuri Andriaccio <yurand2000@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CkhlbGxvLAoKa2VybmVsIHRlc3Qgcm9ib3Qgbm90aWNlZCAibHRwLnByb2Nfc2NoZWRfcnQwMS5m
YWlsIiBvbjoKCmNvbW1pdDogNGYxMDIxZjI5MzY4ZGY3OWE2ZTc5ZWM4N2NhZmEyOWQ5OWE0NjAx
YSAoIltQQVRDSCB2MyA2LzhdIHNjaGVkOiBMaW1pdCBzeXNjdGwgc2NoZWRfcnRfe3BlcmlvZHxy
dW50aW1lfV91cyB0byBSVF9HUk9VUF9TQ0hFRCIpCnVybDogaHR0cHM6Ly9naXRodWIuY29tL2lu
dGVsLWxhYi1sa3AvbGludXgvY29tbWl0cy9TZWJhc3RpYW4tQW5kcnplai1TaWV3aW9yL3NjaGVk
LWRlYWRsaW5lLVJlamVjdC1kZWJ1Z2ZzLWRsX3NlcnZlci13cml0ZXMtZm9yLW5vdC1hY3RpdmUt
Q1BVcy8yMDI2MTExMy0xMTUwMjIKcGF0Y2ggbGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzIwMjYxMTEzLXNjaGVkX2RsLXYzLTYtYTc2ZmZhMWNkZWVlQGxpbnV0cm9uaXguZGUvCnBh
dGNoIHN1YmplY3Q6IFtQQVRDSCB2MyA2LzhdIHNjaGVkOiBMaW1pdCBzeXNjdGwgc2NoZWRfcnRf
e3BlcmlvZHxydW50aW1lfV91cyB0byBSVF9HUk9VUF9TQ0hFRAoKaW4gdGVzdGNhc2U6IGx0cAp2
ZXJzaW9uOiBsdHAteDg2XzY0LTY4NmEzMzFiNi0xXzIwMjYxMTE0IHdpdGggZm9sbG93aW5nIHBh
cmFtZXRlcnM6CgoJdGVzdDogc2NoZWQKCmNvbmZpZzogeDg2XzY0LXJoZWwtOS40LWx0cApjb21w
aWxlcjogZ2NjLTE0CnRlc3QgbWFjaGluZTogOCB0aHJlYWRzIDEgc29ja2V0cyBJbnRlbChSKSBD
b3JlKFRNKSBpNy00NzkwVCBDUFUgQCAyLjcwR0h6IChIYXN3ZWxsKSB3aXRoIDE2RyBtZW1vcnkK
CihwbGVhc2UgcmVmZXIgdG8gYXR0YWNoZWQgZG1lc2cva21zZyBmb3IgZW50aXJlIGxvZy9iYWNr
dHJhY2UpCgoKSWYgeW91IGZpeCB0aGUgaXNzdWUgaW4gYSBzZXBhcmF0ZSBwYXRjaC9jb21taXQg
KGkuZS4gbm90IGp1c3QgYSBuZXcgdmVyc2lvbiBvZiB0aGUgc2FtZSBwYXRjaC9jb21taXQpLCBr
aW5kbHkgYWRkIGZvbGxvd2luZyB0YWdzCnwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90
IDx5aTEubGFpQGludGVsLmNvbT4KfCBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29l
LWxrcC8yMDI2MTExOTIwMDQuY2NhOGJmNzMtbGtwQGludGVsLmNvbQoKClBBVEg9L2xrcC9iZW5j
aG1hcmtzL2x0cDovdXNyL2xvY2FsL3NiaW46L3Vzci9sb2NhbC9iaW46L3Vzci9zYmluOi91c3Iv
YmluOi9sa3AvbGtwL3NyYy9iaW4KMjAyNi0xMS0xOSAwMzo1NToyMSBjZCAvbGtwL2JlbmNobWFy
a3MvbHRwCjIwMjYtMTEtMTkgMDM6NTU6MjEgZXhwb3J0IExUUF9SVU5USU1FX01VTD0yCjIwMjYt
MTEtMTkgMDM6NTU6MjEgZXhwb3J0IExUUFJPT1Q9L2xrcC9iZW5jaG1hcmtzL2x0cAoyMDI2LTEx
LTE5IDAzOjU1OjIxIGtpcmsgLWYgc2NoZWQKSG9zdCBpbmZvcm1hdGlvbgoJSG9zdG5hbWU6ICAg
bGtwLWhzdy1kMDUKCVB5dGhvbjogICAgIDMuMTMuNSAobWFpbiwgSnVuIDEzIDIwMjYsIDE0OjE4
OjAxKSBbR0NDIDE0LjIuMF0KCURpcmVjdG9yeTogIC90bXAva2lyay5yb290L3RtcG16d3FiNDNs
CgpDb25uZWN0aW5nIHRvIFNVVDogZGVmYXVsdAoKU3VpdGU6IHNjaGVkCuKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgAogWzE7MzdtcHRoX3N0cjAxOiAgWzBtIFsxOzMybXBhc3Mg
WzBtICAoMC4wMTZzKQogWzE7MzdtcHRoX3N0cjAyOiAgWzBtIFsxOzMybXBhc3MgWzBtICAoMC4x
NTFzKQogWzE7MzdtcHRoX3N0cjAzOiAgWzBtIFsxOzMybXBhc3MgWzBtICAoMC4wMTdzKQogWzE7
MzdtdGltZS1zY2hlZHVsZTAxOiAgWzBtIFsxOzMybXBhc3MgWzBtICAoMC4yNTBzKQogWzE7Mzdt
dHJhY2Vfc2NoZWQwMTogIFswbSBbMTszMm1wYXNzIFswbSAgKDAuMDIxcykKIFsxOzM3bWNmc19i
YW5kd2lkdGgwMTogIFswbSBbMTszMm1wYXNzIFswbSAgKDE1LjA4NXMpCiBbMTszN21oYWNrYmVu
Y2gwMTogIFswbSBbMTszMm1wYXNzIFswbSAgKDQ5LjI3OXMpCiBbMTszN21oYWNrYmVuY2gwMjog
IFswbSBbMTszMm1wYXNzIFswbSAgKDE5LjU1NHMpCiBbMTszN21zdGFydmF0aW9uOiAgWzBtIFsx
OzM2bXNraXAgWzBtICAoMC4wNzZzKQogWzE7MzdtcHJvY19zY2hlZF9ydDAxOiAgWzBtIFsxOzMx
bWZhaWwgWzBtICAoMC4wMTVzKQogWzE7Mzdtc2NoZWRfY2xpX3NlcnY6ICBbMG0gWzE7MzJtcGFz
cyBbMG0gICg1LjA0M3MpCiBbMTszN21zY2hlZF9zdHJlc3M6ICBbMG0gWzE7MzJtcGFzcyBbMG0g
ICgxbSAxMnMpCiBbMTszN21hdXRvZ3JvdXAwMTogIFswbSBbMTszMm1wYXNzIFswbSAgKDAuMDc1
cykKIFsxOzM3bXNjaGVkX2Zvb3RiYWxsOiAgWzBtIFsxOzMybXBhc3MgWzBtICAoNS40NjlzKQoK
RXhlY3V0aW9uIHRpbWU6IDJtIDQ3cwoKRGlzY29ubmVjdGluZyBmcm9tIFNVVDogZGVmYXVsdAoK
VGFyZ2V0IGluZm9ybWF0aW9uCuKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgApLZXJuZWw6ICAgTGludXggNy40LjAtcmMyKyAjMSBTTVAgUFJFRU1Q
VCBUaHUgTm92IDE5IDExOjE4OjI5IENTVCAyMDI2CkNtZGxpbmU6ICBpcD06Ojo6bGtwLWhzdy1k
MDU6OmRoY3AKICAgICAgICAgIHJvb3Q9L2Rldi9yYW0wCiAgICAgICAgICBSRVNVTFRfUk9PVD0v
cmVzdWx0L2x0cC9zY2hlZC9sa3AtaHN3LWQwNS9kZWJpYW4tMTMteDg2XzY0LTIwMjUwOTAyLmNn
ei94ODZfNjQtcmhlbC05LjQtbHRwL2djYy0xNC80ZjEwMjFmMjkzNjhkZjc5YTZlNzllYzg3Y2Fm
YTI5ZDk5YTQ2MDFhLzAKICAgICAgICAgIEJPT1RfSU1BR0U9L3BrZy9saW51eC94ODZfNjQtcmhl
bC05LjQtbHRwL2djYy0xNC80ZjEwMjFmMjkzNjhkZjc5YTZlNzllYzg3Y2FmYTI5ZDk5YTQ2MDFh
L3ZtbGludXotNy40LjAtcmMyKwogICAgICAgICAgYnJhbmNoPWludGVybmFsLWRldmVsL2RldmVs
LWhvdXJseS0yMDI2MTExNy0wMjQ0MTgKICAgICAgICAgIGpvYj0vbGtwL2pvYnMvc2NoZWR1bGVk
L2xrcC1oc3ctZDA1L2x0cC1zY2hlZC1kZWJpYW4tMTMteDg2XzY0LTIwMjUwOTAyLmNnei00ZjEw
MjFmMjkzNjgtMjAyNjExMTktMzUzMjQtMTFkNjJ0bS0wLnlhbWwKICAgICAgICAgIHVzZXI9bGtw
CiAgICAgICAgICBBUkNIPXg4Nl82NAogICAgICAgICAga2NvbmZpZz14ODZfNjQtcmhlbC05LjQt
bHRwCiAgICAgICAgICBjb21taXQ9NGYxMDIxZjI5MzY4ZGY3OWE2ZTc5ZWM4N2NhZmEyOWQ5OWE0
NjAxYQogICAgICAgICAgaW50cmVtYXA9cG9zdGVkX21zaQogICAgICAgICAgbWF4X3VwdGltZT03
MjAwCiAgICAgICAgICBMS1BfU0VSVkVSPWludGVybmFsLWxrcC1zZXJ2ZXIKICAgICAgICAgIG5v
a2FzbHIKICAgICAgICAgIHNlbGludXg9MAogICAgICAgICAgZGVidWcKICAgICAgICAgIGFwaWM9
ZGVidWcKICAgICAgICAgIHN5c3JxX2Fsd2F5c19lbmFibGVkCiAgICAgICAgICByY3VwZGF0ZS5y
Y3VfY3B1X3N0YWxsX3RpbWVvdXQ9MTAwCiAgICAgICAgICBuZXQuaWZuYW1lcz0wCiAgICAgICAg
ICBwcmludGsuZGV2a21zZz1vbgogICAgICAgICAgcGFuaWM9LTEKICAgICAgICAgIHNvZnRsb2Nr
dXBfcGFuaWM9MQogICAgICAgICAgbm1pX3dhdGNoZG9nPXBhbmljCiAgICAgICAgICBvb3BzPXBh
bmljCiAgICAgICAgICBsb2FkX3JhbWRpc2s9MgogICAgICAgICAgcHJvbXB0X3JhbWRpc2s9MAog
ICAgICAgICAgZHJiZC5taW5vcl9jb3VudD04CiAgICAgICAgICBzeXN0ZW1kLmxvZ19sZXZlbD1l
cnIKICAgICAgICAgIGlnbm9yZV9sb2dsZXZlbAogICAgICAgICAgY29uc29sZT10dHkwCiAgICAg
ICAgICBlYXJseXByaW50az10dHlTMCwxMTUyMDAKICAgICAgICAgIGNvbnNvbGU9dHR5UzAsMTE1
MjAwCiAgICAgICAgICB2Z2E9bm9ybWFsCiAgICAgICAgICBydwogICAgICAgICAga2VlcF9pbml0
cmRzPS9vc2ltYWdlL3BrZy9kZWJpYW4tMTMteDg2XzY0LTIwMjUwOTAyLmNnei9sdHAteDg2XzY0
LTY4NmEzMzFiNi0xXzIwMjYxMTE0LmNnegogICAgICAgICAgYWNwaV9yc2RwPTB4MDAwZjA0OTAK
TWFjaGluZTogIHVua25vd24KQXJjaDogICAgIHg4Nl82NApSQU06ICAgICAgMTQwMzM3NTYga0IK
U3dhcDogICAgIDAga0IKRGlzdHJvOiAgIGRlYmlhbiAxMwoK4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACiAgICAg
IFRFU1QgU1VNTUFSWQrilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDilIDi
lIDilIDilIDilIDilIDilIDilIDilIDilIDilIAKU3VpdGU6ICAgc2NoZWQKUnVudGltZTogMm0g
NDdzClJ1bnM6ICAgIDE0CgpSZXN1bHRzOgogICAgUGFzc2VkOiAgIDIyCiAgICBGYWlsZWQ6ICAg
MwogICAgQnJva2VuOiAgIDEKICAgIFNraXBwZWQ6ICAxCiAgICBXYXJuaW5nczogMAoKIFsxOzMx
bUJyb2tlbjogWzBtCiAgICDigKIgcHJvY19zY2hlZF9ydDAxCgogWzE7MzFtRmFpbHVyZXM6IFsw
bQogICAg4oCiIHByb2Nfc2NoZWRfcnQwMQoKU2Vzc2lvbiBzdG9wcGVkCkxUUCB0ZXN0IGRldGFp
bHMKLS0tLS0tLS0tLS0tLS0tLQpzdGFydmF0aW9uOiBzdGFydmF0aW9uLmM6MTE1OiBUQ09ORjog
U2tpcCB0ZXN0IGR1ZSB0byBzbG93IGtlcm5lbCBjb25maWd1cmF0aW9uCnByb2Nfc2NoZWRfcnQw
MTogcHJvY19zY2hlZF9ydDAxLmM6NDU6IFRGQUlMOiBlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVs
L3NjaGVkX3J0X3BlcmlvZF91cyBleHBlY3RlZCBFSU5WQUw6IEVCQURGICg5KQpwcm9jX3NjaGVk
X3J0MDE6IHByb2Nfc2NoZWRfcnQwMS5jOjQ3OiBURkFJTDogZWNobyAtMSA+IC9wcm9jL3N5cy9r
ZXJuZWwvc2NoZWRfcnRfcGVyaW9kX3VzIGV4cGVjdGVkIEVJTlZBTDogRUJBREYgKDkpCnByb2Nf
c2NoZWRfcnQwMTogcHJvY19zY2hlZF9ydDAxLmM6NTM6IFRGQUlMOiBlY2hvIC0yID4gL3Byb2Mv
c3lzL2tlcm5lbC9zY2hlZF9ydF9ydW50aW1lX3VzIGV4cGVjdGVkIEVJTlZBTDogRUJBREYgKDkp
CnByb2Nfc2NoZWRfcnQwMTogcHJvY19zY2hlZF9ydDAxLmM6NjI6IFRCUk9LOiBGYWlsZWQgdG8g
b3BlbiBGSUxFICcvcHJvYy9zeXMva2VybmVsL3NjaGVkX3J0X3BlcmlvZF91cycgZm9yIHJlYWRp
bmc6IEVOT0VOVCAoMikKCgpUaGUga2VybmVsIGNvbmZpZyBhbmQgbWF0ZXJpYWxzIHRvIHJlcHJv
ZHVjZSBhcmUgYXZhaWxhYmxlIGF0OgpodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNpL2Fy
Y2hpdmUvMjAyNjExMTkvMjAyNjExMTkyMDA0LmNjYThiZjczLWxrcEBpbnRlbC5jb20KCi0tCjAt
REFZIENJIEtlcm5lbCBUZXN0IFNlcnZpY2UKaHR0cHM6Ly9naXRodWIuY29tL2ludGVsL2xrcC10
ZXN0cy93aWtpCgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
