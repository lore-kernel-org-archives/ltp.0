Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B716606A324
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=T0xL47Vb;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=hB3TSCjH
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56AD83EA9A1
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 15:27:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE0543EA0BF
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 15:23:51 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6357F1400C60
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 15:23:51 +0100 (CET)
Date: Thu, 19 Nov 2026 15:23:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1795098230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sFju/1HR8D4dGfEsV9o9IsWma24lYxtJ3WMUExZI3CM=;
 b=T0xL47VbEsUbhj2RinyONMU2/ofHZXyc9bMcofgkQ2RiSxRzL9YUli0b3MjC3CRLdSjWw+
 CdTbMmcisggITNMMGvaXS4U1Dg0QTcPO31+bqYELe6RpbrdSF53b9Ybrly8r8PWqUjZxQ3
 BnRGIvZBg/kBFeFy5bCbMCdmblcEGCwyAmr4G2B0Oi/u6T4glU5b+0nyXUtAS+2kcfPaKE
 a1kusWTLGmSwgCtcNcd42yv3sy7G0H8bZGiBm2oUDRlpE5yO3vNMeQbm/Kxe+ptTXdpiu6
 UT1FlePKgJvTeweokPV2JjSGn8nn+SS4pj6iSD6YvPc8AHJBojMsHVs7ZJzdRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1795098230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sFju/1HR8D4dGfEsV9o9IsWma24lYxtJ3WMUExZI3CM=;
 b=hB3TSCjHaJc0Tb+O4RfNg+PzzpZkdB6FNKDa3Y8i52g+wfjZ2gSZH3CSN9c8sBBjo/O0cw
 5oEHHy4C+qexRpCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: kernel test robot <yi1.lai@intel.com>
Message-ID: <20261119142348.MkPQ2Fby@linutronix.de>
References: <20261113-sched_dl-v3-6-a76ffa1cdeee@linutronix.de>
 <202611192004.cca8bf73-lkp@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202611192004.cca8bf73-lkp@intel.com>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
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
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun@kernel.org>,
 Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Ben Segall <bsegall@google.com>,
 John Ogness <john.ogness@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Vincent Guittot <vincent.guittot@linaro.org>, yu.c.chen@intel.com,
 Jonathan Corbet <corbet@lwn.net>, luca abeni <luca.abeni@santannapisa.it>,
 aubrey.li@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>,
 rcu@vger.kernel.org, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, ltp@lists.linux.it, lkp@intel.com,
 Zqiang <qiang.zhang@linux.dev>, Joel Fernandes <joelagnelf@nvidia.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, oe-lkp@lists.linux.dev,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Yuri Andriaccio <yurand2000@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjAyNi0xMS0xOSAyMjoxMToxMCBbKzA4MDBdLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90ZToK
PiAgWzE7MzFtQnJva2VuOiBbMG0KPiAgICAg4oCiIHByb2Nfc2NoZWRfcnQwMQo+IAo+ICBbMTsz
MW1GYWlsdXJlczogWzBtCj4gICAgIOKAoiBwcm9jX3NjaGVkX3J0MDEKPiAKPiBTZXNzaW9uIHN0
b3BwZWQKPiBMVFAgdGVzdCBkZXRhaWxzCj4gLS0tLS0tLS0tLS0tLS0tLQo+IHN0YXJ2YXRpb246
IHN0YXJ2YXRpb24uYzoxMTU6IFRDT05GOiBTa2lwIHRlc3QgZHVlIHRvIHNsb3cga2VybmVsIGNv
bmZpZ3VyYXRpb24KPiBwcm9jX3NjaGVkX3J0MDE6IHByb2Nfc2NoZWRfcnQwMS5jOjQ1OiBURkFJ
TDogZWNobyAwID4gL3Byb2Mvc3lzL2tlcm5lbC9zY2hlZF9ydF9wZXJpb2RfdXMgZXhwZWN0ZWQg
RUlOVkFMOiBFQkFERiAoOSkKPiBwcm9jX3NjaGVkX3J0MDE6IHByb2Nfc2NoZWRfcnQwMS5jOjQ3
OiBURkFJTDogZWNobyAtMSA+IC9wcm9jL3N5cy9rZXJuZWwvc2NoZWRfcnRfcGVyaW9kX3VzIGV4
cGVjdGVkIEVJTlZBTDogRUJBREYgKDkpCj4gcHJvY19zY2hlZF9ydDAxOiBwcm9jX3NjaGVkX3J0
MDEuYzo1MzogVEZBSUw6IGVjaG8gLTIgPiAvcHJvYy9zeXMva2VybmVsL3NjaGVkX3J0X3J1bnRp
bWVfdXMgZXhwZWN0ZWQgRUlOVkFMOiBFQkFERiAoOSkKPiBwcm9jX3NjaGVkX3J0MDE6IHByb2Nf
c2NoZWRfcnQwMS5jOjYyOiBUQlJPSzogRmFpbGVkIHRvIG9wZW4gRklMRSAnL3Byb2Mvc3lzL2tl
cm5lbC9zY2hlZF9ydF9wZXJpb2RfdXMnIGZvciByZWFkaW5nOiBFTk9FTlQgKDIpCgpUaGUgdGVz
dCB3cml0ZXMgdG8gdGhvc2UgZmllcyBhbmQgbm93IGNvbXBsYWlucyBiZWNhdXNlIHRoZSBmaWxl
cyBkb24ndApleGlzdC4gTXkgaW50ZW50aW9uIHdhcyB0byByZW1vdmUgdGhvc2UgZmlsZXMgYmVj
YXVzZSB3cml0aW5nIHRvIHRoZW0Kc2VydmVzIG5vIHB1cnBvc2UgYW5kIHBlb3BsZSBkb24ndCBr
bm93IHRoaXMgYW5kIF9hc3N1bWVfIHRoZXkgZGlzYWJsZQpSVCB0aHJvdHRsaW5nLgoKU2ViYXN0
aWFuCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
