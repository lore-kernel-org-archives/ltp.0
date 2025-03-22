Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC260C35FFC
	for <ltp@archiver.kernel.org>; Sat, 22 Mar 2025 23:15:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B55CF3C1896
	for <ltp@archiver.kernel.org>; Sun, 23 Mar 2025 00:15:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7BA93C0463
 for <ltp@lists.linux.it>; Sun, 23 Mar 2025 00:14:48 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CF9071400242
 for <ltp@lists.linux.it>; Sun, 23 Mar 2025 00:14:47 +0100 (CET)
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4769f3e19a9so20492691cf.0
 for <ltp@lists.linux.it>; Sat, 22 Mar 2025 16:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742685286; x=1743290086;
 darn=lists.linux.it; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XJHqDIUEdiSQHsyrP8cT37rDikvtCQ4w65f+7jAbskE=;
 b=l4PpcL0pDzAR3gDmwJXTG1T/m1PJXGF2xqxha1J1Udm0sMcIn0mVRWdXRNKAzjv6ug
 CfTAguK2dAiMhnwx4IM7U4RmJer+K/TvIUJNKlm7xH6JSPjyK5UreAWfnSk3uGiQr0ZE
 iEerSD6rcvJ7dCDCRA3PfllNVKz1Eu7oX+/ILwsoRz+3mNTRug6aKBDDbgGLdCCia8eq
 e1qJMudkNt7xOdcKfyKHg7VVqrn6fOmWuSsPHPVqaaz69aZTmjzWsd9ybVVctwHA1Q+c
 tDnAOB63BCqQr99idNaTm6BztLQz3PuTty/YZjRJE3hKoGLCvfdjFSjRhJI25sN1lzAk
 2n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742685286; x=1743290086;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XJHqDIUEdiSQHsyrP8cT37rDikvtCQ4w65f+7jAbskE=;
 b=LEYG6adhL5BKU+eVtnod2h/rOoAKQ9ixagsmqNNEWL3x5/fl/REY5cKsGMC+mApFC8
 pWyCEZ+P0Z3b01EljXXrAGvSufy92y3hXD+ONsxl7fMC/b/opaxz4ocfZNtA2kAbif88
 Tng7FhmAywD7vcC8jnUcDRRzbgDZsnuQgGxIxqh7o2s/fYVZQdWnT6PPNRRzjwplevyi
 jm5n/cjmbTA3onmCsjIb5ZKyfV2Q+D7b0KFNPpg0F8zYtVXftthAA9DtrH2xIbcYOAj1
 /pYB0PhMqay8PNoae9g5K/mc5LiO2uXbPYdHPbFhZR5DTNUBknBeY3BeqYIvKlbrIPqA
 g5Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa5yjRPRGkgJg8gYGS7WFKLtSNWs6PImjUhwbJhE1oAafZmwm7WGTP120BEuwu2x2qPfs=@lists.linux.it
X-Gm-Message-State: AOJu0YyCdHL5FQlem6xN7EAPg9eQUkcLcruRtQB/qpYHb4ikQ4mph/hW
 uIjr8xvtxBKWmapLa3AyoTg841aMz7ugbMRawZoR7i8Te3UfLVbaVizAD+yYFT8=
X-Gm-Gg: ASbGncvpV+1U1aHw433O2TY+9cEGiYq9Ncejr2b6cltQzqajpYMnqpPoRirGJDuhDM2
 k5AJQBiPOf5LY4I9h0KE8rZWO0N6lwqTS7dAqqrstCOti0PL6bPzrrVRnd7cJMXvpbqjyz0UGiE
 IpCvL9oBQii7JvdNR7MERniUPC5vfye4fcFb6Q5CZYy0K8QSxHnyDIrHe/FPnNC33HR5buYD2LY
 7UfIEBjhE8XlFXdVQZafwbRL/5Tiu+4QlwUCViDYwv3gODaf0uYg8nDuDt+4O6uPvVYnLTbqf8u
 FQYSkK8hY9nTMH06GOEc5+3RagUnvshxho/MhLCyqrU=
X-Google-Smtp-Source: AGHT+IGn+Hfwrgke1zQGLzwV/3qh9WnxZhHDgrV3gDmuUHLVptmjftr0MP8pFPzrqZlO7fZJloZXWg==
X-Received: by 2002:a05:622a:2513:b0:476:8132:c556 with SMTP id
 d75a77b69052e-4771de61284mr143182971cf.48.1742685286373; 
 Sat, 22 Mar 2025 16:14:46 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
 by smtp.gmail.com with UTF8SMTPSA id
 d75a77b69052e-4771d18f6a3sm27701901cf.38.2025.03.22.16.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 16:14:45 -0700 (PDT)
Date: Sat, 22 Mar 2025 19:14:40 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Message-ID: <20250322231440.GA1894930@cmpxchg.org>
References: <20250311-testphasen-behelfen-09b950bbecbf@brauner>
 <Z9kEdPLNT8SOyOQT@xsang-OptiPlex-9020>
 <Z9krpfrKjnFs6mfE@bombadil.infradead.org>
 <Z9mFKa3p5P9TBSTQ@casper.infradead.org>
 <Z9n_Iu6W40ZNnKwT@bombadil.infradead.org>
 <Z9oy3i3n_HKFu1M1@casper.infradead.org>
 <Z9r27eUk993BNWTX@bombadil.infradead.org>
 <Z9sYGccL4TocoITf@bombadil.infradead.org>
 <Z9sZ5_lJzTwGShQT@casper.infradead.org>
 <Z9wF57eEBR-42K9a@bombadil.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z9wF57eEBR-42K9a@bombadil.infradead.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [block/bdev] 3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
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
Cc: Pankaj Raghav <p.raghav@samsung.com>, Daniel Gomez <da.gomez@samsung.com>,
 Christian Brauner <brauner@kernel.org>, David Bueso <dave@stgolabs.net>,
 Jan Kara <jack@suse.cz>, lkp@intel.com, David Hildenbrand <david@redhat.com>,
 Alistair Popple <apopple@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 Oliver Sang <oliver.sang@intel.com>, Hannes Reinecke <hare@suse.de>,
 John Garry <john.g.garry@oracle.com>, oe-lkp@lists.linux.dev,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hey Luis,

On Thu, Mar 20, 2025 at 05:11:19AM -0700, Luis Chamberlain wrote:
> On Wed, Mar 19, 2025 at 07:24:23PM +0000, Matthew Wilcox wrote:
> > On Wed, Mar 19, 2025 at 12:16:41PM -0700, Luis Chamberlain wrote:
> > > On Wed, Mar 19, 2025 at 09:55:11AM -0700, Luis Chamberlain wrote:
> > > > FWIW, I'm not seeing this crash or any kernel splat within the
> > > > same time (I'll let this run the full 2.5 hours now to verify) on
> > > > vanilla 6.14.0-rc3 + the 64k-sector-size patches, which would explain why I
> > > > hadn't seen this in my earlier testing over 10 ext4 profiles on fstests. This
> > > > particular crash seems likely to be an artifact on the development cycle on
> > > > next-20250317.
> > > 
> > > I confirm that with a vanilla 6.14.0-rc3 + the 64k-sector-size patches a 2.5
> > > hour run generic/750 doesn't crash at all. So indeed something on the
> > > development cycle leads to this particular crash.
> > 
> > We can't debug two problems at once.
> > 
> > FOr the first problem, I've demonstrated what the cause is, and that's
> > definitely introduced by your patch, so we need to figure out a
> > solution.
> 
> Sure, yeah I followed that.
> 
> > For the second problem, we don't know what it is.  Do you want to bisect
> > it to figure out which commit introduced it?
> 
> Sure, the culprit is the patch titled:
> 
> mm: page_alloc: trace type pollution from compaction capturing
> 
> Johannes, any ideas? You can reproduce easily (1-2 minutes) by running
> fstests against ext4 with a 4k block size filesystem on linux-next
> against the test generic/750.

Sorry for the late reply, I just saw your emails now.

> Below is the splat decoded.
> 
> Mar 20 11:52:55 extra-ext4-4k kernel: Linux version 6.14.0-rc6+ (mcgrof@beefy) (gcc (Debian 14.2.0-16) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #51 SMP PREEMPT_DYNAMIC Thu Mar 20 11:50:32 UTC 2025
> Mar 20 11:52:55 extra-ext4-4k kernel: Command line: BOOT_IMAGE=/boot/vmlinuz-6.14.0-rc6+ root=PARTUUID=503fa6f2-2d5b-4d7e-8cf8-3a811de326ce ro console=tty0 console=tty1 console=ttyS0,115200n8 console=ttyS0
> 
> < -- etc -->
> 
> Mar 20 11:55:27 extra-ext4-4k unknown: run fstests generic/750 at 2025-03-20 11:55:27
> Mar 20 11:55:28 extra-ext4-4k kernel: EXT4-fs (loop5): mounted filesystem c20cbdee-a370-4743-80aa-95dec0beaaa2 r/w with ordered data mode. Quota mode: none.
> Mar 20 11:56:29 extra-ext4-4k kernel: BUG: unable to handle page fault for address: ffff93098000ba00
> Mar 20 11:56:29 extra-ext4-4k kernel: #PF: supervisor read access in kernel mode
> Mar 20 11:56:29 extra-ext4-4k kernel: #PF: error_code(0x0000) - not-present page
> Mar 20 11:56:29 extra-ext4-4k kernel: PGD 3a201067 P4D 3a201067 PUD 0
> Mar 20 11:56:29 extra-ext4-4k kernel: Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
> Mar 20 11:56:29 extra-ext4-4k kernel: CPU: 0 UID: 0 PID: 74 Comm: kcompactd0 Not tainted 6.14.0-rc6+ #51
> Mar 20 11:56:29 extra-ext4-4k kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
> Mar 20 11:56:29 extra-ext4-4k kernel: RIP: 0010:__zone_watermark_ok (mm/page_alloc.c:3256) 
> Mar 20 11:56:29 extra-ext4-4k kernel: Code: 00 00 00 41 f7 c0 38 02 00 00 0f 85 2c 01 00 00 48 8b 4f 30 48 63 d2 48 01 ca 85 db 0f 84 f3 00 00 00 49 29 d1 bb 80 00 00 00 <4c> 03 54 f7 38 31 d2 4d 39 ca 0f 8d d2 00 00 00 ba 01 00 00 00 85
> All code
> ========
>    0:	00 00                	add    %al,(%rax)
>    2:	00 41 f7             	add    %al,-0x9(%rcx)
>    5:	c0 38 02             	sarb   $0x2,(%rax)
>    8:	00 00                	add    %al,(%rax)
>    a:	0f 85 2c 01 00 00    	jne    0x13c
>   10:	48 8b 4f 30          	mov    0x30(%rdi),%rcx
>   14:	48 63 d2             	movslq %edx,%rdx
>   17:	48 01 ca             	add    %rcx,%rdx
>   1a:	85 db                	test   %ebx,%ebx
>   1c:	0f 84 f3 00 00 00    	je     0x115
>   22:	49 29 d1             	sub    %rdx,%r9
>   25:	bb 80 00 00 00       	mov    $0x80,%ebx
>   2a:*	4c 03 54 f7 38       	add    0x38(%rdi,%rsi,8),%r10		<-- trapping instruction

This looks like the same issue the bot reported here:

https://lore.kernel.org/all/20250321135524.GA1888695@cmpxchg.org/

There is a fix for it queued in next-20250318 and later. Could you
please double check with your reproducer against a more recent next?

Thanks

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
