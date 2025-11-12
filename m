Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A85CD4843
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 21:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762981587; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=KRmTzSlC+vZufQ6TZcoC+n+BPtsXQVbHtJYedxzqsps=;
 b=rQpkZpK/5Zf4FSHbXM8Mvo5cxnEMeOTP4MFDXJ5BkUZ1z7iLDVkrps1mIhNKANxhnUFK8
 VIbu+v2Zclpm3JjvFcO916bxWrlGsgUayu7APOnvxPpIxw55NiOm8fUC8GD7paSPP58XOfC
 Nk6g5+i4yP7Bs/RUA6/5PAtypDYitoA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5398B3CF7CE
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 22:06:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 496CF3CF779
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 22:06:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8F8DD1400993
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 22:06:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762981564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fCNF5Uk/lGD5LlkBgnbSiEUZcmadNjNrT3Pdpoarlzc=;
 b=dWPzxdhxhljVrk+odHCLQVk2TIcrA7JWejFPg43STt/ECs7KOa2S62twhzQq7kqie+ptFt
 PVlSaISjA5edmRkdszACcq1WrXnDsgBwGVJOO0NuundB1JiLORbXi7X68EclR5AmP6kJVk
 H3oXvmCrhpRURVNK95XDnUq/UC5gw9U=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-PKa_V7MtM6ahMP85WY4XOg-1; Wed, 12 Nov 2025 16:06:02 -0500
X-MC-Unique: PKa_V7MtM6ahMP85WY4XOg-1
X-Mimecast-MFC-AGG-ID: PKa_V7MtM6ahMP85WY4XOg_1762981562
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88236bcdfc4so3533966d6.1
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 13:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762981562; x=1763586362;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fCNF5Uk/lGD5LlkBgnbSiEUZcmadNjNrT3Pdpoarlzc=;
 b=RXzWV2Lymyy0kOrX6mu9mwPbwCOclvt1OY1sfJ5kO55gACOsOruFhWgTCnJ0SXQi4/
 Jduk5Xxrd1HeJJ4ca6IvNF3EKyEhcC+/3Pdbz9SlATAxe94Ge3o4cHPjKZ4JnGoLr9GP
 34UgA6NEpc0xoYJkyRnNq3D3/QidlNHtwsC151qxL03o8GV9mBbpPS+qxH6tdos2Du4W
 cRyjejUZJsDHRSHdpxFC5YU8DHlWEAPzRsz47xy4re89ya962JvTNhBpivFsHEY55v3x
 C0Tyzkf/Egk+oS4pt1bOKY0pRXiaAS+2LA6D0Uk+1pxWSBsb4O9HS6fQQAw+BK8g3WqJ
 T6tQ==
X-Gm-Message-State: AOJu0Yz+GlVJCsR0vgZO6k4LIwUW7W7iIidCN4S5XRPgaSHsU2R2Ch9K
 QYu1cfs/anAq6OblZgsFWhXXXtTwkRaJ+P1kWFACb1bbA5scoXYbRcp2Z6lUgAPgTAYJgqIBo+1
 TnYGMRUAEIm9A0gq3Qhq4tN5JLl33VJ69V/rjYWJD7Dt3cGyM+wd3fpNXe+pMBtWpkkIBRyLwOX
 IoZ0lYx0AtIgxgd46ariTguSkC02w=
X-Gm-Gg: ASbGncv7dLkgw4y3JrtnMmAJJlGDOdXk/uDaLtG74oeY7DSMt3lU0kouwajRD79KtT1
 WJBOAiEE2xUyoIynLkvKsIc9IwU37yoW13sLy0DHOExjUWO7Uvmy71oP0xQpBY+6yW5eSgs/VC5
 qKNhB/sYYVvbaUGcYGIm+GznpDxNg3vDAxf/HYecRduQDJUWGZakqYWqKp
X-Received: by 2002:a05:6214:2528:b0:880:3dfd:6265 with SMTP id
 6a1803df08f44-88271a501ffmr61162556d6.42.1762981561680; 
 Wed, 12 Nov 2025 13:06:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxSPn3Z3TiXAsyvj7vLo+44GqMhxXsjD7U6XiNJxXfHjGqJ/EOZ6bLskCu/BA++UDvnArci3K/wLsq87TlIEc=
X-Received: by 2002:a05:6214:2528:b0:880:3dfd:6265 with SMTP id
 6a1803df08f44-88271a501ffmr61162046d6.42.1762981561265; Wed, 12 Nov 2025
 13:06:01 -0800 (PST)
MIME-Version: 1.0
References: <20251112180319.630584-1-sbertram@redhat.com>
 <20251112201124.GA157071@pevik>
In-Reply-To: <20251112201124.GA157071@pevik>
Date: Wed, 12 Nov 2025 16:05:50 -0500
X-Gm-Features: AWmQ_bmJcHfg8JVT10AONII2MquysRa83b48qlQv2GVGLB0Ma6QSBQqpH8Hhhpc
Message-ID: <CAD_=S2=jJFLvESH9c0-a41-tTKFDQDovX3T47af7-2WXmH8rgw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: j46kxQjyN92XSMsA3jBo8h3z-kw0_n7y_7ESfswlnT0_1762981562
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] Add new tests for clone and clone3
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
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKT24gV2VkLCBOb3YgMTIsIDIwMjUgYXQgMzoxN+KAr1BNIFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gSGkgQmVuLAo+CnN0ZXBoZW4KCj4KPiAuLi4KPiA+ICsv
KlwKPiA+ICsgKiBUaGlzIHRlc3QgdmVyaWZpZXMgdGhhdCBjbG9uZSgpIGZhbHMgd2l0aCBFUEVS
TSB3aGVuIENBUF9TWVNfQURNSU4KPiBzL2ZhbHMvZmFpbHMvCj4KPiBJZiBuZXcgdmVyc2lvbiBp
cyBuZWVkZWQsIGNvdWxkIHlvdSBwbGVhc2UgdXNlIDptYW4yOmBjbG9uZWAgPwo+IFRoaXMgd2ls
bCBsaW5rIG1hbiBjbG9uZSgyKSBbMl0gaW4gb3VyIHRlc3QgY2F0YWxvZyBbM10uCj4KU28gSSdt
IGNsZWFyLCBhIGxvdCBpcyBuZXcgdG8gbWUgaGVyZSwgSSBzaG91bGQgcmVwbGFjZSAiY2xvbmUo
KSIgd2l0aAo6bWFuOmBjbG9uZWAKV2lsbCB0aGUgc2FtZSB3b3JrIGZvciBjbG9uZTM/IGkuZS4g
Om1hbjpgY2xvbmUzYD8KCkkgdW5kZXJzdGFuZCB0aGUgb3RoZXIgY29tbWVudHMgYW5kIHdpbGwg
aW1wbGVtZW50IHRoZW0sIG5pdCBvciBub3QgOikuCgo+ClRoYW5rIHlvdSBmb3IgdGhlIGZlZWRi
YWNrLgoKc3RlcGhlbgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
