Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B637D4A5EA
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 02:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768530928; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=hsCTmJZhf7Z6JiGbE2Lm9okIIuF592BrsGreJXrNBF4=;
 b=HHGVdKdGCWyzOKlMegFk29ztM7MmZDM72Qcac0ZTooYFDBilHqJCQb+CDdDWa1TZk1hHm
 rVvVJpHR9YacHHXhV5vdY6SOrQXZ+aiMHZAQMQ/yhAEYtxaNCONH6sX/JU3MS0FMGArwHbX
 lN4bLZeVvkEehWgc6Cui4G7fLlJn7is=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2DD13CA558
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 03:35:28 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 921C23CA4FB
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 03:35:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2B534600A78
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 03:35:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768530902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbYbiZw1/XA22YCnhwAOQi4/i472uDm0kQ+CUeT+5Rk=;
 b=EXad3FJyTzJZIL8o5RuljZF8BzkenN51XGHPzV78V9KFdtaNrC/w07mgKbvBUQUHoeveHh
 rrTh/l8UK5NI0Gn/b2nZhgCU5+F4eEvMWEaKW013paKmYQ90yI5oNUMY6nlR2cNO0tqRlD
 y6R8sdWev4FweRRsh43MOUv6ztFZICI=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-o_BxXFqUP1uJeChLJg9-6A-1; Thu, 15 Jan 2026 21:35:01 -0500
X-MC-Unique: o_BxXFqUP1uJeChLJg9-6A-1
X-Mimecast-MFC-AGG-ID: o_BxXFqUP1uJeChLJg9-6A_1768530900
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ae26a77b76so3024515eec.0
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 18:35:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768530899; x=1769135699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DbYbiZw1/XA22YCnhwAOQi4/i472uDm0kQ+CUeT+5Rk=;
 b=HM9U821M6ZP9ZSLtAaCdD1WOMUEMHqEvzLxKM9GwBcNkEBSih4nY/YS0xczIn/XWVp
 y2f4CamEnd9wkv8Hltlo7A88qNmmVLj/1ANZRQpCYLdJURTdxJxVIR6TMYtlHemVM5Tq
 ze7VK1O4pHetcmA7DIGIzhHFKd1Zy9jqgSg2ne5kyYjsMxX/D4DAGBwMaWqjWWLyIA7e
 v/ue/hjn0QN2Ahkz8Pkds9aLzpkJcOoZUkv4pSgQKid8tU0oXv0k3lewoyp6Ae/gtxO3
 onboXG/dPVu0LebZ8jQglF+J9V6M7KtRpHWI0aIqPXPBckCFPdtgyYYb4sndnXNng9QR
 3XhQ==
X-Gm-Message-State: AOJu0Yz/Fr62Z/4XxZP0QEPW4IhhrpbkBGuoBRhJJfbhuFufKbcXHpwX
 QXWndj7nlygsSzFECWAkYG85Nnnmi8LXx9Aaz1l4HRLGHx3XN1mwoFtMO2Jey7sNkj8ZHlMRJCP
 jW8eXuWvuGY+9GWwfZloUAce9p1yq3RwUTZ7FetXdzO/drU2lici/mAawMUQL1rQ9rNmVxRuaLS
 cABqA10HKlvMLLye5CWZ7kxC7FaDE5K5SmkcBLkg==
X-Gm-Gg: AY/fxX6w4+OFQAk0ulUUktoTvyd8mMTaaR1Ht8l2BPNHJL6HI9KJrE1kpI1ewD+tBTr
 bzzjoHXHSEqI+jvNc/QXgAUZHhd0uFL3sSKAbFf35diNjpAOp+Fdmsif/uSgASkixz96ZgwW9p0
 W0ocFdGg1FcyumBKzB97kXM4BOEpLzERuPTRzudcrYPvKIvo1yfGIv+flZm+EeMS4tfGg=
X-Received: by 2002:a05:7300:7493:b0:2ae:605b:d52f with SMTP id
 5a478bee46e88-2b6b4ebf448mr1355360eec.39.1768530898577; 
 Thu, 15 Jan 2026 18:34:58 -0800 (PST)
X-Received: by 2002:a05:7300:7493:b0:2ae:605b:d52f with SMTP id
 5a478bee46e88-2b6b4ebf448mr1355344eec.39.1768530897972; Thu, 15 Jan 2026
 18:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20260115153439.13337-1-chrubis@suse.cz>
 <20260115153439.13337-3-chrubis@suse.cz>
In-Reply-To: <20260115153439.13337-3-chrubis@suse.cz>
Date: Fri, 16 Jan 2026 10:34:46 +0800
X-Gm-Features: AZwV_QiH4AXD14UlsR2Q48F8dXqDs_xlJOVk_fyH7FOyJ_7oYOBNGjFD8aHNwG4
Message-ID: <CAEemH2exhOPPnvxtHjETacq_pEHn4-wrwv4xbecTQ395oZMNKw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3kxOOPW0v-kZa4UajsoGOQOsRNhnwOF2QvMzaO2wdLw_1768530900
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] doc: Add ground rules page
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiArRG9u4oCZdCByZXF1aXJlIHJvb3QgdW5sZXNzIGl04oCZcyBlc3NlbnRpYWwKPiArLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICsKPiArSWYgcm9vdC9jYXBzIGFy
ZSBuZWVkZWQsIHNheSB3aHkgaW4gdGhlIHRlc3QgZG9jIGNvbW1lbnQuIERyb3AgcHJpdmlsZWdl
cyBmb3IKPiArdGhlIHBhcnQgdGhhdCBkb2VzbuKAmXQgbmVlZCB0aGVtIGFuZCBhdm9pZCBydW5u
aW5nIHRoZSB3aG9sZSB0ZXN0IGFzIHJvb3QKPiAr4oCcYmVjYXVzZSBpdOKAmXMgZWFzaWVy77+9
4oKsPy4KClRoaXMgcGFyYWdyYXBoIGNvbnRhaW5zIHNvbWUgbm9uLUFTQ0lJIGNoYXJhY3RlcnMs
IHdlIG5lZWQgc3dpdGNoIHRvCnBsYWluIEFTQ0lJLgpUaGV5IHdlcmUgaW5zZXJ0ZWQgYnkgbXkg
a2V5Ym9hcmQgb3JpZ2luYWxseS4gU29ycnkgYWJvdXQgdGhhdC4KCgotRG9u4oCZdCByZXF1aXJl
IHJvb3QgdW5sZXNzIGl04oCZcyBlc3NlbnRpYWwKK0Rvbid0IHJlcXVpcmUgcm9vdCB1bmxlc3Mg
aXQncyBlc3NlbnRpYWwKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
CiBJZiByb290L2NhcHMgYXJlIG5lZWRlZCwgc2F5IHdoeSBpbiB0aGUgdGVzdCBkb2MgY29tbWVu
dC4gRHJvcCBwcml2aWxlZ2VzIGZvcgotdGhlIHBhcnQgdGhhdCBkb2VzbuKAmXQgbmVlZCB0aGVt
IGFuZCBhdm9pZCBydW5uaW5nIHRoZSB3aG9sZSB0ZXN0IGFzIHJvb3QKLeKAnGJlY2F1c2UgaXTi
gJlzIGVhc2llcuKAnS4KK3RoZSBwYXJ0IHRoYXQgZG9lc24ndCBuZWVkIHRoZW0gYW5kIGF2b2lk
IHJ1bm5pbmcgdGhlIHdob2xlIHRlc3QgYXMgcm9vdAorImJlY2F1c2UgaXQncyBlYXNpZXIiLgoK
Ci0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
