Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847D0C369C2
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 07:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745306685; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=AUxkMfnGl+h92ySnrVHwQwXmUBNCX34R6RZJfc0CdNA=;
 b=CCe7LsDpdjGTEUCmU0M/q2IquJaJJ+HTw1abm33x/DLg1PIlkEi4KNag6/6WePlbPKYrk
 dGbvI9JvRAy8NK1CQlMUdf03fYk9nRuUSrNBOrKebH1INXvbkRAe7H8IRZd4347rzfi3eKI
 KEYtTs0xNc0z+Aj5Ipgbcjfz9utiLgg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 372CD3CBB87
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 09:24:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF3253CA82E
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 09:24:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DE189600807
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 09:24:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745306659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHq8JnczvAp02iNHDUTUV1ZWlMSP2ObMyyAHgUg1X4E=;
 b=idk7awJmMtTZGaQO7dAF8yOvhUyf2gLDAw2/5MeCD3L2Ic0ZisPmDrrTKPrG7FDZ0+/9YW
 x3zu9STrOoHc9Lj/uhcX3ejX5/rCYjKpXnbeLUgF4tzu/KsPilwaK3VDQLEHTROWVv0TJU
 PUzdDJhbQ8d7LA27XV8kbblGzOSSYgg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-EG4C1NTzMHmY_-omqkTMWw-1; Tue, 22 Apr 2025 03:24:17 -0400
X-MC-Unique: EG4C1NTzMHmY_-omqkTMWw-1
X-Mimecast-MFC-AGG-ID: EG4C1NTzMHmY_-omqkTMWw_1745306656
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39130f02631so1650475f8f.2
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 00:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745306656; x=1745911456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EHq8JnczvAp02iNHDUTUV1ZWlMSP2ObMyyAHgUg1X4E=;
 b=uk5ZlKZEMhrVuTry0+tJyQV0S/eVFhkYyo07d9HU2qpZOVZ/1q4Jab5LzjMauh6n+z
 9P6K++AZDClDDL4pL2jmdvEb9STiAV0FIRToFgA7+sXp2bSEILIFdc4j90Hq+RGeiA3q
 h4Ch7EnST9dv3MfabdGJGNgEM4926PPN5TWQfeMIZ0U6l2byGaaatSQCWiqRiR17EGPT
 B7UUld3Oj46ZzgxdX7+IxqJP/Bu4xpbmGvWRLAEP94FNiStASMjj3HLPj18aRdJRMNja
 wjizJxXRm9FFhb7/KXlUk5VGQDN+Vob3Re0par/XAG9BDO7xMLkAfN6xTbyoThjazb0v
 cwGA==
X-Gm-Message-State: AOJu0Ywj1Gt8kQfGvohTThYY1AHnOab2AzdhCh+moXnWfEpYLXU7buQO
 ZVQjQ7M+BpDUHEED0ycTzqI/Ly7QD/cu0xS5oMH1yrInfOIyxM3uuXA+vED0zPJBf5Il4xuZW42
 bu60nkD4LVJRq14hw/+V2/5hF4O9C54t1DyQLiZzNwPWmoiVezqjZlJf0ruDJklbIi3wxH0O+Kg
 orT4vYIGY6uQcY8OiypHD827A=
X-Gm-Gg: ASbGncsezMc1+lB9YTMLGwZ3ZI+5vQ8kK4jD4V6RrodZkTqFrxERmAgVMbjL0Xg8W0W
 bPyo3NZoOFPIn8aEEpQyJR08R2nY1QsmJGgo8mqgVH09Dy3pcQlmQT+s4GL4z3EqLT8VX
X-Received: by 2002:a5d:598f:0:b0:39f:edf:2b61 with SMTP id
 ffacd0b85a97d-39f0edf2b97mr3043034f8f.11.1745306656279; 
 Tue, 22 Apr 2025 00:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYQO40QlIv9cCMcwQuNUOOfF0TY0XG+WVFsgCkujVMzJfGCyK41/piMtPhvcVOrnutYwvBwYOQVUBqcaYITiU=
X-Received: by 2002:a5d:598f:0:b0:39f:edf:2b61 with SMTP id
 ffacd0b85a97d-39f0edf2b97mr3043017f8f.11.1745306655999; Tue, 22 Apr 2025
 00:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <8c3549cbda426969943a2beefa4f50f214b1a8c4.1744878941.git.jstancek@redhat.com>
 <20250417112017.GC655134@pevik>
In-Reply-To: <20250417112017.GC655134@pevik>
Date: Tue, 22 Apr 2025 09:23:59 +0200
X-Gm-Features: ATxdqUFRNSTrNikpX7RtNQqWbJ0VAwEjvoPeUSFINjITZ1V8-tF5NQz17fMd78I
Message-ID: <CAASaF6zVREjO2NrQ9jamg5DZjWVWCZGg8L2r3VqEkSr8bDtJOw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TA8ow6-hvhL39j878UIN6CMlRY0Rcl2a4QAwlBzGGOU_1745306656
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] libswap: 6.15 supports one more swapfile with
 CONFIG_DEVICE_PRIVATE
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBcHIgMTcsIDIwMjUgYXQgMToyMOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEphbiwKPgo+IFRoYW5rcyBmb3IgZml4aW5nIGl0IQo+IFJldmll
d2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgo+ID4gU2luY2UgYzI1NDY1ZWI3
NjMwICgibW06IHVzZSBzaW5nbGUgU1dQX0RFVklDRV9FWENMVVNJVkUgZW50cnkgdHlwZSIpCj4g
PiBrZXJuZWwgc3VwcG9ydHMgb25yZSBtb3JlIHN3YXAgZmlsZS4KPiBzL29ucmUvb25lLwoKUHVz
aGVkIHdpdGggdHlwbyBmaXhlZC4KCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+CgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
