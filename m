Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3954A606A320
	for <ltp@archiver.kernel.org>; Fri, 20 Nov 2026 15:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=mX5EbUb4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FKTEVT6M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795189020; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Gn5+0gJJC3mOFdN0H0gg/r2z3iDOOh53Wu8X9zPmQdo=;
 b=mX5EbUb4esGGoAVsYdVsF9WS4KD+qYs4oBz76XZ8TKXrIMQpaWZTPxBcdt3lKts3etyKL
 wdeNJC+ZJEtB8Wk63/tOfgHRXRBcmqWb7W5hE+18R/taZqVx2ZabBwRKwtfC2UWjLPSdCcJ
 904CViaFS9foqcWMQg9dp+7IyGHnSL0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 858003E9FCD
	for <ltp@archiver.kernel.org>; Fri, 20 Nov 2026 16:37:00 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A76F3E9FC1
 for <ltp@lists.linux.it>; Fri, 20 Nov 2026 16:07:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D2F8514010E3
 for <ltp@lists.linux.it>; Fri, 20 Nov 2026 16:07:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795187223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O0TPK5M5hrUDnQg4DmTQaVPUwM9tdKMHp47PNrEqGW0=;
 b=FKTEVT6MFJl495kupXoN9cmZMHA+Jfd6q6Jfq4FLspKXwwweay9KcJJ8H0+2w5L3enVlpl
 jfEP73alJfSCCnvDAPBwSaDDQ7OD40OAzWdsQPrpAL7XGBxok5s/By1Er9sRxurGAbmbLc
 A3zqr2xJW8ggTjGc44teWNu4cssWtX0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-0XtDPSyVMe6Nfw6RP2yaUA-1; Fri, 20 Nov 2026 15:07:00 +0000
X-MC-Unique: 0XtDPSyVMe6Nfw6RP2yaUA-1
X-Mimecast-MFC-AGG-ID: 0XtDPSyVMe6Nfw6RP2yaUA_1795187219
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a70b42bab0so9011125e9.1
 for <ltp@lists.linux.it>; Fri, 20 Nov 2026 07:07:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795187219; x=1795792019;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=O0TPK5M5hrUDnQg4DmTQaVPUwM9tdKMHp47PNrEqGW0=;
 b=nz4dQZ/dOgHM0WwrTZ1s2eLVGBRPYNLbn4UO1R6hPIz7bSNhtQn0VutMcsHo7a0FIl
 SdEIdg0PP29sps8QEfsXEYLD7lVbCRruE4AfhTxFntdIlt9QXFxDgbyughGS5Lx03y7x
 WQ0+/MTh9trByrykz1Q8Hdr0L6wv5bkVWHnFBQHROHcoyL0pR6cyA6MID8BzNmRk5uQg
 arO7h/q39YJso7OJXgsai9eT/WoR3su1QrdVMRUZwQJ2m64iMlk3gkLzGCkLhLy00Rab
 JFMhG6SPzeuJwioaU4TsSGUdIsKxyW3q8PvM5YfcI54KLTjNSGJ95eOnETzDyHdv1Q7u
 7lwg==
X-Forwarded-Encrypted: i=1;
 AL+hErErApS5D69f2hGVnUFgVzIDju4yIF09diXU/QEIyGtpy0u2ulvACDdMUhejqaXq0RVbeOQ=@lists.linux.it
X-Gm-Message-State: APuU4Z+KLkQIEb3smAxixk1oUwq9xM8JNEcvpJC1oe5oyCd88ORHLdZH
 51lZWrakczUx/WuD+9PBD4mEXS2zkEXwpuLSQG2Okw4T7peYdSpU6PcokZzw6NYZ/uXgy0rjWC5
 yFAoVjCbjEChiJHHRpLOgTGLkQvmMIiJ8cyPfIz0XF4ot5qK00aZI
X-Gm-Gg: AYBFou193buyyUfLQKszwWYQAu5VXZmiRTyugWLAYuxPoj/Y9T6vFi2g83weOhVTge6
 UEz2R0GAr6DU4GrPe0pClo9EB0xTfcYoBREevyc1LKi2li53tEOamfqQNcdCCbFgNjZ3m/4a9pp
 67rjhpVejf2/BAEcvJpYhopOmyY1KXdOrdZ1HpXu84ue8a/a0bkvrdnU9rSbgMSgAMX7D9iBll0
 oAxlHK1vSweWk2fCb2Bw76zmgU83EkmNqzqaOKX2XLB2KlpVWDgL+NNhM7mayJbzm50Zl+f/Urj
 kfoCMc2uoZjXJoFlJmGJBmxSE5EILnRLWd55qqbA9uijNsLo7Xbt/r25LPh2A/bdpA+FIUAuej1
 rGjLUIh1ymOLJoiGeawogIIXqBYvsvcwt+Lcu0Gazp5uHUcEoABbWizFEA3K5JO09EKePJWiFRq
 c3z8k=
X-Received: by 2002:a05:600c:4585:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4bb8881b8e4mr73498125e9.17.1795187219420; 
 Fri, 20 Nov 2026 07:06:59 -0800 (PST)
X-Received: by 2002:a05:600c:4585:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4bb8881b8e4mr73497495e9.17.1795187219045; 
 Fri, 20 Nov 2026 07:06:59 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849247asm92714315e9.7.2026.11.20.07.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:06:58 -0800 (PST)
Date: Fri, 20 Nov 2026 16:06:55 +0100
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Message-ID: <awBiDzEvUch_5ZJn@jlelli-thinkpadt14gen4.remote.csb>
References: <20261113-sched_dl-v3-6-a76ffa1cdeee@linutronix.de>
 <202611192004.cca8bf73-lkp@intel.com>
 <20261119142348.MkPQ2Fby@linutronix.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261119142348.MkPQ2Fby@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D4l8nRd0AWhVLBWGQX30S9vEUWtOc2qwfXgwUQjA4jg_1795187219
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 20 Nov 2026 16:36:41 +0100
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
From: Juri Lelli via ltp <ltp@lists.linux.it>
Reply-To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun@kernel.org>,
 Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Ben Segall <bsegall@google.com>,
 John Ogness <john.ogness@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Vincent Guittot <vincent.guittot@linaro.org>, yu.c.chen@intel.com,
 Jonathan Corbet <corbet@lwn.net>, luca abeni <luca.abeni@santannapisa.it>,
 aubrey.li@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, ltp@lists.linux.it, lkp@intel.com,
 Zqiang <qiang.zhang@linux.dev>, Joel Fernandes <joelagnelf@nvidia.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
 kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Yuri Andriaccio <yurand2000@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpPbiAxOS8xMS8yNiAxNToyMywgU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciB3cm90
ZToKPiBPbiAyMDI2LTExLTE5IDIyOjExOjEwIFsrMDgwMF0sIGtlcm5lbCB0ZXN0IHJvYm90IHdy
b3RlOgo+ID4gIFsxOzMxbUJyb2tlbjogWzBtCj4gPiAgICAg4oCiIHByb2Nfc2NoZWRfcnQwMQo+
ID4gCj4gPiAgWzE7MzFtRmFpbHVyZXM6IFswbQo+ID4gICAgIOKAoiBwcm9jX3NjaGVkX3J0MDEK
PiA+IAo+ID4gU2Vzc2lvbiBzdG9wcGVkCj4gPiBMVFAgdGVzdCBkZXRhaWxzCj4gPiAtLS0tLS0t
LS0tLS0tLS0tCj4gPiBzdGFydmF0aW9uOiBzdGFydmF0aW9uLmM6MTE1OiBUQ09ORjogU2tpcCB0
ZXN0IGR1ZSB0byBzbG93IGtlcm5lbCBjb25maWd1cmF0aW9uCj4gPiBwcm9jX3NjaGVkX3J0MDE6
IHByb2Nfc2NoZWRfcnQwMS5jOjQ1OiBURkFJTDogZWNobyAwID4gL3Byb2Mvc3lzL2tlcm5lbC9z
Y2hlZF9ydF9wZXJpb2RfdXMgZXhwZWN0ZWQgRUlOVkFMOiBFQkFERiAoOSkKPiA+IHByb2Nfc2No
ZWRfcnQwMTogcHJvY19zY2hlZF9ydDAxLmM6NDc6IFRGQUlMOiBlY2hvIC0xID4gL3Byb2Mvc3lz
L2tlcm5lbC9zY2hlZF9ydF9wZXJpb2RfdXMgZXhwZWN0ZWQgRUlOVkFMOiBFQkFERiAoOSkKPiA+
IHByb2Nfc2NoZWRfcnQwMTogcHJvY19zY2hlZF9ydDAxLmM6NTM6IFRGQUlMOiBlY2hvIC0yID4g
L3Byb2Mvc3lzL2tlcm5lbC9zY2hlZF9ydF9ydW50aW1lX3VzIGV4cGVjdGVkIEVJTlZBTDogRUJB
REYgKDkpCj4gPiBwcm9jX3NjaGVkX3J0MDE6IHByb2Nfc2NoZWRfcnQwMS5jOjYyOiBUQlJPSzog
RmFpbGVkIHRvIG9wZW4gRklMRSAnL3Byb2Mvc3lzL2tlcm5lbC9zY2hlZF9ydF9wZXJpb2RfdXMn
IGZvciByZWFkaW5nOiBFTk9FTlQgKDIpCj4gCj4gVGhlIHRlc3Qgd3JpdGVzIHRvIHRob3NlIGZp
ZXMgYW5kIG5vdyBjb21wbGFpbnMgYmVjYXVzZSB0aGUgZmlsZXMgZG9uJ3QKPiBleGlzdC4gTXkg
aW50ZW50aW9uIHdhcyB0byByZW1vdmUgdGhvc2UgZmlsZXMgYmVjYXVzZSB3cml0aW5nIHRvIHRo
ZW0KPiBzZXJ2ZXMgbm8gcHVycG9zZSBhbmQgcGVvcGxlIGRvbid0IGtub3cgdGhpcyBhbmQgX2Fz
c3VtZV8gdGhleSBkaXNhYmxlCj4gUlQgdGhyb3R0bGluZy4KCkkgYWdyZWUgb24gdGhlIFJUIHRo
cm90dGxpbmcgcGFydC4gQmVmb3JlIHRoaXMgc2VyaWVzLCB3cml0aW5nIHRvIHRoZW0KZG9lcyBz
ZXJ2ZSBhIHB1cnBvc2UsIHRob3VnaC4gNS84IG1vdmVzIHRoYXQgZnVuY3Rpb25hbGl0eSB0byBz
eXNmcywKd2hpY2ggbGVhdmVzIHRoZSBmaWxlcyB3aXRob3V0IGEgcHVycG9zZSwgYW5kIDYvOCB0
aGVuIHJlbW92ZXMgdGhlbS4gU28KZXhpc3RpbmcgdXNlcnMgZG9uJ3QgbG9zZSBhIHVzZWxlc3Mg
a25vYjsgdGhleSBsb3NlIHRoZSB3b3JraW5nIG9uZSwKd2hpY2ggaGFzIG1vdmVkIHNvbWV3aGVy
ZSBlbHNlLiBMVFAgaXMgbm90IHRoZSBvbmx5IG9uZSB0aGF0IHdpbGwKbm90aWNlLCBJJ20gYWZy
YWlkLgoKVGhpcyBpcyB3aGF0IEkgbWVhbnQgd2l0aCAieWVzIGFuZCBubyIgaW4gdGhlIFJGQyB0
aHJlYWQ6IHdlIG5lZWQgYW4KaW50ZXJmYWNlIGZvciBhZG1pc3Npb24gY29udHJvbCwgYW5kIEkg
d2Fzbid0IHN1cmUgaG93IG11Y2ggYnJlYWthZ2UKbW92aW5nIGl0IHdvdWxkIGNhdXNlLiBOb3cg
d2UgaGF2ZSBhIGZpcnN0IGRhdGEgcG9pbnQuIDopCgpZb3Ugc3VnZ2VzdGVkIHlvdXJzZWxmIGJh
Y2sgdGhlbiB0byBrZWVwIHRoZSBmaWxlcyBhbmQgbWFrZSB0aGVtIGFwcGx5CnRvIERMIG9ubHku
IEkgdGhpbmsgdGhhdCdzIHNvbWV0aGluZyBsaWtlOgoKIC0ga2VlcCBzY2hlZF9ydF97cGVyaW9k
LHJ1bnRpbWV9X3VzIGZvciAhUlRfR1JPVVBfU0NIRUQsIGJhY2tlZCBieSB0aGUKICAgc2FtZSBj
b2RlIGFzIHRoZSBuZXcgZGxfe3BlcmlvZCxydW50aW1lfV91cyAoc2NoZWRfZGxfdHJ5X2JvdW5k
YXJ5KCkpLAogICBrZWVwaW5nIHRoZSBjdXJyZW50IHZhbGlkYXRpb24gc2VtYW50aWNzICh0aGUg
TFRQIHRlc3QgY2hlY2tzIHRoZQogICBFSU5WQUwgY2FzZXMsIGFuZCAwIGlzIGEgdmFsaWQgcnVu
dGltZSB0b2RheSkKIC0gcHJfd2Fybl9vbmNlKCkgb24gd3JpdGUgc2F5aW5nIHRoZXkgb25seSBj
b250cm9sIERFQURMSU5FIGFkbWlzc2lvbgogICBjb250cm9sIGFuZCB0aGF0IFJUIHRocm90dGxp
bmcgaXMgaGFuZGxlZCBieSB0aGUgZmFpcl9zZXJ2ZXIsCiAgIHBvaW50aW5nIHRvIHdoZXJlIGl0
cyBrbm9icyBhcmUKIC0gZml4IHRoZSBkb2N1bWVudGF0aW9uIGFzIHlvdSBhcmUgZG9pbmcgYWxy
ZWFkeQoKVGhhdCB3YXkgbm9ib2R5IGdldHMgc3VycHJpc2VkIGFueW1vcmUsIHdoaWNoIHdhcyB5
b3VyIHBvaW50LCBhbmQgd2UKZG9uJ3QgYnJlYWsgYW55b25lPyBXZSBjYW4gc3RpbGwgZGlzY3Vz
cyBkZXByZWNhdGluZyB0aGUgcHJvY2ZzIG5hbWVzCmxhdGVyLCBvbmNlIHRoZSBuZXcgaW50ZXJm
YWNlIGhhcyBiZWVuIGFyb3VuZCBmb3IgYSB3aGlsZSBtYXliZT8KClRoYW5rcywKSnVyaQoKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
