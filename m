Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701C0C433EF
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 15:59:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CDCA3C6C13
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 16:59:34 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8ED613C093A
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 17:58:34 +0100 (CET)
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [207.82.80.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C7AF01000740
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 17:58:33 +0100 (CET)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-8-dyIDGajdPWOdiVq8f9AjNQ-1; Tue, 23 Nov 2021 16:58:31 +0000
X-MC-Unique: dyIDGajdPWOdiVq8f9AjNQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Tue, 23 Nov 2021 16:58:31 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Tue, 23 Nov 2021 16:58:30 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'David Howells' <dhowells@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [PATCH] uapi: Make __{u,s}64 match {u,}int64_t in userspace
Thread-Index: AQHX4InVzhztkrNZME2rQ+mb6OtfjawRUyrg
Date: Tue, 23 Nov 2021 16:58:30 +0000
Message-ID: <ff8fc4470c8f45678e546cafe9980eff@AcuMS.aculab.com>
References: <YZvIlz7J6vOEY+Xu@yuki> <1618289.1637686052@warthog.procyon.org.uk>
In-Reply-To: <1618289.1637686052@warthog.procyon.org.uk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 30 Nov 2021 16:58:59 +0100
Subject: Re: [LTP] [PATCH] uapi: Make __{u, s}64 match {u,
 }int64_t in userspace
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
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: David Howells
> Sent: 23 November 2021 16:48
> 
> Cyril Hrubis <chrubis@suse.cz> wrote:
> 
> > This changes the __u64 and __s64 in userspace on 64bit platforms from
> > long long (unsigned) int to just long (unsigned) int in order to match
> > the uint64_t and int64_t size in userspace.

That is a massive UAPI change you can't do.

> Can you guarantee this won't break anything in userspace?  Granted the types
> *ought* to be the same size, but anyone who's written code on the basis that
> these are "(unsigned) long long int" may suddenly get a bunch of warnings
> where they didn't before from the C compiler.  Anyone using C++, say, may find
> their code no longer compiles because overloaded function matching no longer
> finds a correct match.

Indeed

> Also, whilst your point about PRIu64 and PRId64 modifiers in printf() is a
> good one, it doesn't help someone whose compiler doesn't support that (I don't
> know if anyone's likely to encounter such these days).  At the moment, I think
> a user can assume that %llu will work correctly both on 32-bit and 64-bit on
> all arches, but you're definitely breaking that assumption.

PRIu64 (etc) don't require compiler support, just the correct header file.

I'm pretty sure that portable user code needs to allow for int64_t being
either 'long' or 'long long' on 64bit architectures.
(Indeed 'long' may not even be 64bit.)

On 32bit int32_t can definitely be either 'int' of 'long' at whim.

I'm not sure anyone has tried a 64bit long with a 128bit long-long.
But the C language might lead you to do that.

Of course, fully portable code has to allow for char, short, int and long
all being the same size!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
