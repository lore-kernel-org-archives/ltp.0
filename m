Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A71CAC592
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 04:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757997368; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=xDYSmm6euFThvxvcgKfv7ElQgE/TM8MkR5919DxTSPI=;
 b=V+g3GMr2hH48cq6ueNowVbfLj11wY3khiVgqYoO+513Mx+/AVj2JL6HQ9GbN1yXdzja4y
 UUe93htS2WbFnSpiKzwTYuQ8JfJEaWhnTCVIBt+BpYbBUNsLGI86MpsHX/fwccNWbMe0wg8
 rYdYUewXHz5aF0SkP1vlQbovp0NOnbs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 223A23CDABE
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 06:36:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 876243C1844
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 06:35:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 89894600102
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 06:35:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757997344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XItt5b1pp525J3W8OrhEa6Xr45XioOIyiLnvZomEjto=;
 b=SNygxBY1KN2vAkj/jK4i13b4fOK4Ff6ZGTypSGO+rOT3l+suD/9JKpMKGICEzjD70MXt1/
 A2aRr+dFQEi17pk8fAEmokPnLpubcZWlVTroidgapafsnHbM4n9uC3OpGVapVhNLrtbF/9
 TOefF3oW6mgJc8Sq/S+/i+JJ8w4jk5Y=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-Tvn-CcRgP8OktFjOCmd4cA-1; Tue, 16 Sep 2025 00:35:42 -0400
X-MC-Unique: Tvn-CcRgP8OktFjOCmd4cA-1
X-Mimecast-MFC-AGG-ID: Tvn-CcRgP8OktFjOCmd4cA_1757997341
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b54a2ab0f2aso2821703a12.1
 for <ltp@lists.linux.it>; Mon, 15 Sep 2025 21:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757997341; x=1758602141;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ViITMPokExA6sfXHaE6QM+QK2xJDlONm1OPjdrPmkdk=;
 b=c5YoQWduuwVr6O2C4hro3JC1sOL/Ki37343u8EB2pr69Q20KvPYA1Sf9tTmfP7sYzv
 fQe1HtPdDdLQcqFdELOOg9+Tk8HFFO0MUlbZozOjdiQVTsxAn6KYY7rczJTFC2ovkeRO
 1IDIQXq83z5hGvH3015IVDpKji9TwbMWpSYGCLp3G2O+FDCjB47kzNnqAQqPHoO5AT2E
 aqGXbVJ3MBDeTASinfUlZ7pj0hJ23YBJDhdG8NlHOBpG7/1YK+Bp+A+mmvYZRPIUj0b3
 kP3fqSUiQr40y4qs3bsrE+yqdzySEbTRnJkWsuc9KTYMSpEsyA5K8lHt/O1Tk8GpG/43
 94VQ==
X-Gm-Message-State: AOJu0YzJEutxY8ReNHpuWHFDYEuAt6nmDA7xd0L9OFFJGfXtPnplmRAa
 g8iGIFN05VaQVZdHdhR/80PRzJhaP+hGjf2yfnRBLUioc8YSrFSp4PSddWt6gp90cKXQdpVoauA
 sZEjn1Vv3ngcn2Vwy0kv8N7ZSIUGfn4/vHA5YRkmKVOVJjwj4wOyNj3K5a2iTBkU/wYgZ2zUMOK
 yuZj1LbW0l5Xok6PB4PGGNFKv0e6c=
X-Gm-Gg: ASbGnctC17EVc/25Y6Js1IwOjP1kQ9dhcadJfTN6LSEZd4j/Q9sHpUVQxnWIkHlGAG7
 LPUZEFQTWIf+fiOIdLbR016VrKMifnf6LlvfLJZR5b8goJrU7WiveAG3PcTjNvCUNrrIw9pXjWU
 8erY8A+aQNPJBIjDF/s87UhA==
X-Received: by 2002:a05:6a20:1590:b0:263:57a:bb46 with SMTP id
 adf61e73a8af0-266ec2392ecmr1273040637.13.1757997341085; 
 Mon, 15 Sep 2025 21:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvtQQk99O2j8RWDtU1kX+MMqJ5rqEqRVHCdTN4z+bLozAeKuzwvbd8xjJkHk/BFsTy54HKW+50kdRYLcO21aY=
X-Received: by 2002:a05:6a20:1590:b0:263:57a:bb46 with SMTP id
 adf61e73a8af0-266ec2392ecmr1273009637.13.1757997340620; Mon, 15 Sep 2025
 21:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2e0TUFeWS7mjfz5FVW_Jb6Pv76YiEXLHY+ojwfGpvfWWw@mail.gmail.com>
In-Reply-To: <CAEemH2e0TUFeWS7mjfz5FVW_Jb6Pv76YiEXLHY+ojwfGpvfWWw@mail.gmail.com>
Date: Tue, 16 Sep 2025 12:35:28 +0800
X-Gm-Features: AS18NWBfBJMMdf5lufk5uWWOUD8uBU46cSMfbJhapy_ub5MKGnWsw-tamIPGBgk
Message-ID: <CAEemH2cTiKAhn2hjr71Qn1-CRHBoFm_FH4Xp3BPQm1arrxUVTA@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qx-rUpt99Cg2TLYz8SBxjqKRv0zXKlOflR8qq5GNJEo_1757997341
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] kirk cannot handle env variable correctly
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

QWZ0ZXIgbG9va2luZyBhdCB0aGUgbHRwLnB5LCBpdCBvdmVycmlkZXMgdGhlIHVzZXItc2V0IExU
UF9USU1FT1VUX01VTCBlbnYKdmFyaWFibGUuClNvIG1heWJlIHdlIG5lZWQgdG8gZW5hYmxlIHRo
YXQgdG8gY29uZmlnIGJ5IC0tZW52LCB3aGF0IGRvIHlvdSB0aGluaz8KCi0tLSBhL2xpYmtpcmsv
bHRwLnB5CisrKyBiL2xpYmtpcmsvbHRwLnB5CkBAIC02NCw3ICs2NCw4IEBAIGNsYXNzIExUUEZy
YW1ld29yayhGcmFtZXdvcmspOgogICAgICAgICAgICAgc2VsZi5fZW52LnVwZGF0ZShlbnYpCgog
ICAgICAgICB0aW1lb3V0ID0gbGlia2lyay50eXBlcy5kaWN0X2l0ZW0oa3dhcmdzLCAidGVzdF90
aW1lb3V0IiwgZmxvYXQpCi0gICAgICAgIGlmIHRpbWVvdXQ6CisgICAgICAgIHVzZXJfdGltZW91
dF9tdWwgPSBvcy5lbnZpcm9uLmdldCgiTFRQX1RJTUVPVVRfTVVMIikKKyAgICAgICAgaWYgdGlt
ZW91dCBhbmQgbm90IHVzZXJfdGltZW91dF9tdWw6CiAgICAgICAgICAgICBzZWxmLl9lbnZbIkxU
UF9USU1FT1VUX01VTCJdID0gc3RyKCh0aW1lb3V0ICogMC45KSAvIDMwMC4wKQoKCk9uIFR1ZSwg
U2VwIDE2LCAyMDI1IGF0IDEyOjIz4oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgoKPiBIaSBBbmRyZWEsIEFsbCwKPgo+IFdlIGRpc2NvdmVyZWQgdGhhdCB0aGUgTFRQIHRl
c3RzIGluIHRoZSBDSSBqb2IgYWxsIGhhZCBhIGZpeGVkIHRpbWVvdXQKPiB2YWx1ZSBzZXQsCj4g
cmVnYXJkbGVzcyBvZiBMVFBfVElNRU9VVF9NVUwgb3IgTFRQX1JVTlRJTUVfTVVMIC4gVGhpcyBv
bmx5IHNlZW1lZAo+IHRvIGhhcHBlbiB3aGVuIHJ1bm5pbmcgS2lyaywgc28gdG8gZGVtb25zdHJh
dGUgdGhlIGlzc3VlIEkgbWFudWFsbHkgcmFuIHRoZQo+IGZvbGxvd2luZyB0ZXN0Ogo+Cj4gPT09
PT09PT09PT09PT09PT0KPiAjIC4va2lyayAtLWZyYW1ld29yayBsdHA6cm9vdD0vbW50L3Rlc3Rh
cmVhL2x0cCAtLXJ1bi1jb21tYW5kIG1tYXAyMiAtLWVudgo+IExUUF9USU1FT1VUX01VTD0xCj4g
SG9zdCBpbmZvcm1hdGlvbgo+Cj4gU3lzdGVtOiBMaW51eAo+IE5vZGU6IGhwLWRsMzgwZzEwLTAx
LXZtLTAyLnJodHMuZW5nLnBlazIucmVkaGF0LmNvbQo+IEtlcm5lbCBSZWxlYXNlOiA2LjEyLjAt
MTI0LmVsMTAueDg2XzY0K3J0Cj4gS2VybmVsIFZlcnNpb246ICMxIFNNUCBQUkVFTVBUX1JUIEZy
aSBBdWcgMjIgMTE6NDk6MjcgRURUIDIwMjUKPiBNYWNoaW5lIEFyY2hpdGVjdHVyZTogeDg2XzY0
Cj4gUHJvY2Vzc29yOgo+Cj4gVGVtcG9yYXJ5IGRpcmVjdG9yeTogL3RtcC9raXJrLnJvb3QvdG1w
dHlocXYwNzkKPgo+IENvbm5lY3RpbmcgdG8gU1VUOiBob3N0Cj4gbW1hcDIyCj4gdHN0X3RtcGRp
ci5jOjMxNjogVElORk86IFVzaW5nIC90bXAvTFRQX21tYWZYd1EwdiBhcyB0bXBkaXIgKHhmcwo+
IGZpbGVzeXN0ZW0pCj4gdHN0X3Rlc3QuYzoxOTUzOiBUSU5GTzogTFRQIHZlcnNpb246IDIwMjUw
NTMwCj4gdHN0X3Rlc3QuYzoxOTU2OiBUSU5GTzogVGVzdGVkIGtlcm5lbDogNi4xMi4wLTEyNC5l
bDEwLng4Nl82NCtydCAjMSBTTVAKPiBQUkVFTVBUX1JUIEZyaSBBdWcgMjIgMTE6NDk6MjcgRURU
IDIwMjUgeDg2XzY0Cj4gdHN0X2tjb25maWcuYzo4ODogVElORk86IFBhcnNpbmcga2VybmVsIGNv
bmZpZwo+ICcvbGliL21vZHVsZXMvNi4xMi4wLTEyNC5lbDEwLng4Nl82NCtydC9jb25maWcnCj4g
dHN0X3Rlc3QuYzoxNzc0OiBUSU5GTzogT3ZlcmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGggMDVt
IDU0cwo+IG1tYXAyMi5jOjYzOiBUUEFTUzogTUFQX0RST1BQQUJMRSB0ZXN0IHBhc3MuCj4KPiBT
dW1tYXJ5Ogo+IHBhc3NlZCAgIDEKPiBmYWlsZWQgICAwCj4gYnJva2VuICAgMAo+IHNraXBwZWQg
IDAKPiB3YXJuaW5ncyAwCj4KPiBFeGl0IGNvZGU6IDAKPgo+Cj4gRGlzY29ubmVjdGluZyBmcm9t
IFNVVDogaG9zdAo+IFNlc3Npb24gc3RvcHBlZAo+Cj4KPiA9PT09PT09PT09PT09PT09PT0KPiAj
IGV4cG9ydCBMVFBfVElNRU9VVF9NVUw9MQo+ICMgLi9raXJrIC0tZnJhbWV3b3JrIGx0cDpyb290
PS9tbnQvdGVzdGFyZWEvbHRwIC0tcnVuLWNvbW1hbmQgbW1hcDIyCj4gSG9zdCBpbmZvcm1hdGlv
bgo+Cj4gU3lzdGVtOiBMaW51eAo+IE5vZGU6IGhwLWRsMzgwZzEwLTAxLXZtLTAyLnJodHMuZW5n
LnBlazIucmVkaGF0LmNvbQo+IEtlcm5lbCBSZWxlYXNlOiA2LjEyLjAtMTI0LmVsMTAueDg2XzY0
K3J0Cj4gS2VybmVsIFZlcnNpb246ICMxIFNNUCBQUkVFTVBUX1JUIEZyaSBBdWcgMjIgMTE6NDk6
MjcgRURUIDIwMjUKPiBNYWNoaW5lIEFyY2hpdGVjdHVyZTogeDg2XzY0Cj4gUHJvY2Vzc29yOgo+
Cj4gVGVtcG9yYXJ5IGRpcmVjdG9yeTogL3RtcC9raXJrLnJvb3QvdG1wdzVkc3N2dHMKPgo+IENv
bm5lY3RpbmcgdG8gU1VUOiBob3N0Cj4gbW1hcDIyCj4gdHN0X3RtcGRpci5jOjMxNjogVElORk86
IFVzaW5nIC90bXAvTFRQX21tYWZXTWdEViBhcyB0bXBkaXIgKHhmcwo+IGZpbGVzeXN0ZW0pCj4g
dHN0X3Rlc3QuYzoxOTUzOiBUSU5GTzogTFRQIHZlcnNpb246IDIwMjUwNTMwCj4gdHN0X3Rlc3Qu
YzoxOTU2OiBUSU5GTzogVGVzdGVkIGtlcm5lbDogNi4xMi4wLTEyNC5lbDEwLng4Nl82NCtydCAj
MSBTTVAKPiBQUkVFTVBUX1JUIEZyaSBBdWcgMjIgMTE6NDk6MjcgRURUIDIwMjUgeDg2XzY0Cj4g
dHN0X2tjb25maWcuYzo4ODogVElORk86IFBhcnNpbmcga2VybmVsIGNvbmZpZwo+ICcvbGliL21v
ZHVsZXMvNi4xMi4wLTEyNC5lbDEwLng4Nl82NCtydC9jb25maWcnCj4gdHN0X3Rlc3QuYzoxNzc0
OiBUSU5GTzogT3ZlcmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGggMDVtIDU0cwo+IG1tYXAyMi5j
OjYzOiBUUEFTUzogTUFQX0RST1BQQUJMRSB0ZXN0IHBhc3MuCj4KPiBTdW1tYXJ5Ogo+IHBhc3Nl
ZCAgIDEKPiBmYWlsZWQgICAwCj4gYnJva2VuICAgMAo+IHNraXBwZWQgIDAKPiB3YXJuaW5ncyAw
Cj4KPiBFeGl0IGNvZGU6IDAKPgo+Cj4gRGlzY29ubmVjdGluZyBmcm9tIFNVVDogaG9zdAo+IFNl
c3Npb24gc3RvcHBlZAo+Cj4gPT09PT09PT09PT09PT09PQo+ICMgTFRQX1RJTUVPVVRfTVVMPTEg
Li9tbWFwMjIKPiB0c3RfdG1wZGlyLmM6MzE2OiBUSU5GTzogVXNpbmcgL3RtcC9MVFBfbW1hR0hN
NmZUIGFzIHRtcGRpciAoeGZzCj4gZmlsZXN5c3RlbSkKPiB0c3RfdGVzdC5jOjE5NTM6IFRJTkZP
OiBMVFAgdmVyc2lvbjogMjAyNTA1MzAKPiB0c3RfdGVzdC5jOjE5NTY6IFRJTkZPOiBUZXN0ZWQg
a2VybmVsOiA2LjEyLjAtMTI0LmVsMTAueDg2XzY0K3J0ICMxIFNNUAo+IFBSRUVNUFRfUlQgRnJp
IEF1ZyAyMiAxMTo0OToyNyBFRFQgMjAyNSB4ODZfNjQKPiB0c3Rfa2NvbmZpZy5jOjg4OiBUSU5G
TzogUGFyc2luZyBrZXJuZWwgY29uZmlnCj4gJy9saWIvbW9kdWxlcy82LjEyLjAtMTI0LmVsMTAu
eDg2XzY0K3J0L2NvbmZpZycKPiB0c3RfdGVzdC5jOjE3NzQ6IFRJTkZPOiBPdmVyYWxsIHRpbWVv
dXQgcGVyIHJ1biBpcyAwaCAwMW0gMDBzCj4gbW1hcDIyLmM6NjM6IFRQQVNTOiBNQVBfRFJPUFBB
QkxFIHRlc3QgcGFzcy4KPgo+IFN1bW1hcnk6Cj4gcGFzc2VkICAgMQo+IGZhaWxlZCAgIDAKPiBi
cm9rZW4gICAwCj4gc2tpcHBlZCAgMAo+IHdhcm5pbmdzIDAKPgo+Cj4KPiAtLQo+IFJlZ2FyZHMs
Cj4gTGkgV2FuZwo+CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
