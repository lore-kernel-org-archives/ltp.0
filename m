Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A5FDC3DA6E
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 09:16:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CBBC3CD615
	for <ltp@archiver.kernel.org>; Mon,  8 Jan 2024 10:16:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F55B3C86C9
 for <ltp@lists.linux.it>; Sat,  6 Jan 2024 04:52:03 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C4FF611F6F4A
 for <ltp@lists.linux.it>; Sat,  6 Jan 2024 04:52:02 +0100 (CET)
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7ba903342c2so14275639f.3
 for <ltp@lists.linux.it>; Fri, 05 Jan 2024 19:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=landley-net.20230601.gappssmtp.com; s=20230601; t=1704513121; x=1705117921;
 darn=lists.linux.it; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=enno4RDG7Jc2tI8Uw9IJMPfOQP8dq6cok+ed1FX+/z8=;
 b=F6+Zb86vdYRc/y0Vmt60KrQboKgvCq9AO4guUgVKOXEe5tNQDhSd0b0yJK5RLv+l5u
 6ru04ixOBfCk2aSeYpXyrhzSKqYYew8JJ94PujGXnPZ/tCkgBQB+BcjxPcvrkHWx0O66
 y9B2936QaHmPtzlD57KG/unHGz7wzdwxB086a8Ha0cIwX43KLCsoaQ1BCD1ZO9EAENDz
 UdrBbdviWXnYzRtS5NwjBRuqln4bbbEjtqGrwl4eCMuCmGm2nH+bekSFDHr0zLkodEM2
 BprYTUCJQ/DWySeZDtGTio5D3PK2U9xb+Vq4iNg/InjkIz6JCIBfWmfYQ8aNldT5MKgx
 Q2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704513121; x=1705117921;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=enno4RDG7Jc2tI8Uw9IJMPfOQP8dq6cok+ed1FX+/z8=;
 b=klqZCdER5oyHLTMbEjRSca+bCLAkwOMmYKiEQjYZTPEn75lOUgzia5aFYgmEbzldeM
 y1qMUgobyAEUhk60Eumcixi8B0XlVBvOXR6utg1b7JwlB/JS5XYhjpFNUJiF0Fwm05dM
 OE+sAqqxZyKh44NTVI8uWxx0kSqyV/C+DthF6EycrJ2rqUhIVSUZGzBnsOG6uvbsNkx+
 bF3rR+7f5/ubJsqVFmy/pmnHeMJPGDWrEbUMPogEIb7WcxqFp4/a9G5s4NusiZbQ/7kT
 37czolhlW9TMNb2Ol6ci0tI1onNUpRDsSEbfe9rZh1wS85zXwj04VOFa+c5jBIOOt7Sv
 0o0w==
X-Gm-Message-State: AOJu0Yzp9k71mdRmdinZ9VaHf09oW/4x5mQ/QsJ/y82Q5snopn2xbnmK
 Z8mmcWvS+tyOLJxKE/QuVWxDTCtkNYaf6w==
X-Google-Smtp-Source: AGHT+IGTddaSjZgOGB35qmivrEEVWMRiyLxFuiI9YqBmA2e7RS9koXVG6vidS0Xx6CzgCLA+n146Kw==
X-Received: by 2002:a5d:8059:0:b0:7b4:28f8:519 with SMTP id
 b25-20020a5d8059000000b007b428f80519mr667420ior.25.1704513121061; 
 Fri, 05 Jan 2024 19:52:01 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
 by smtp.gmail.com with ESMTPSA id
 ck15-20020a0566383f0f00b004665f85c6d7sm823366jab.4.2024.01.05.19.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 19:52:00 -0800 (PST)
Message-ID: <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
Date: Fri, 5 Jan 2024 21:58:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki> <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
From: Rob Landley <rob@landley.net>
In-Reply-To: <20240105131135.GA1484621@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 08 Jan 2024 10:15:32 +0100
Subject: Re: [LTP] Call for nommu LTP maintainer [was: Re: [PATCH 00/36]
 Remove UCLINUX from LTP]
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
Cc: Jonathan Corbet <corbet@lwn.net>, Linux-sh list <linux-sh@vger.kernel.org>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-riscv <linux-riscv@lists.infradead.org>, buildroot@buildroot.org,
 Greg Ungerer <gerg@linux-m68k.org>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 1/5/24 07:11, Petr Vorel wrote:
>> Nobody is maintaining "uclinux" because that was a distro, but you can build
>> nommu support in buildroot and such, and people do.
> 
> Right, there are nommu users. Will anybody join LTP development to maintain
> nommu support in LTP? The needed work is to add this support to LTP new C API
> [1] and use it in the relevant test. There is some implementation in the old
> API, I have no idea how well it worked.
> 
> If nobody stands for maintaing nommu, we will have to delete it. There is nobody
> from the current maintainers who is using LTP on nommu HW (that is the reason why
> nommu support have not been implemented in the new API).

I'm interested, but overwhelmed. Not sure I've got the spoons to come up to
speed on a new project and give it regular attention just now.

I see you cc'd buildroot (although the message might not go through if you
aren't subscribed, dunno how clogged their moderation queue is these days, and
the cc: list is long enough it might twig anyway). They had a nommu fix go in
earlier this week (commit 98684ba7885b).

That said, qemu supports several nommu platforms and buildroot has defconfigs to
build systems for them:

$ git clone git://buildroot.org/buildroot
$ make help
$ make list-defconfigs | grep qemu
$ make qemu_ppc_bamboo_defconfig
$ make
  (time passes...)
>>> host-gettext-tiny 0.3.2 Extracting
gzip -d -c
/home/landley/buildroot/buildroot/dl/gettext-tiny/gettext-tiny-0.3.2.tar.gz |
tar --strip-components=1 -C
/home/landley/buildroot/buildroot/output/build/host-gettext-tiny-0.3.2   -xf -
mkdir -p
/home/landley/buildroot/buildroot/output/build/host-gettext-tiny-0.3.2/gettext-gnu
xzcat /home/landley/buildroot/buildroot/dl/gettext-tiny/gettext-0.22.4.tar.xz |
tar --strip-components=1 -C
/home/landley/buildroot/buildroot/output/build/host-gettext-tiny-0.3.2/gettext-gnu
 -xf -
xzcat: /home/landley/buildroot/buildroot/dl/gettext-tiny/gettext-0.22.4.tar.xz:
No such file or directory
tar: This does not look like a tar archive
tar: Exiting with failure status due to previous errors
make: *** [package/pkg-generic.mk:209:
/home/landley/buildroot/buildroot/output/build/host-gettext-tiny-0.3.2/.stamp_extracted]
Error 2


Sigh, never build git pull du jour of anything, buildroot's having glitch du
jour. But the point is:

$ grep -rl bamboo board/
board/qemu/ppc-bamboo/readme.txt
$ cat board/qemu/ppc-bamboo/readme.txt
Run the emulation with:

qemu-system-ppc -nographic -M bamboo -kernel output/images/vmlinux -net
nic,model=virtio-net-pci -net user # qemu_ppc_bamboo_defconfig

The login prompt will appear in the terminal that started Qemu
-------------------

In THEORY, once it builds an image (presumably using a tagged release version
rather than expecting "continuous integration" to ever mean anything) you should
be able to launch it with qemu. Assuming the instructions aren't also
bit-rotted. (Or using one of the other nommu boards, I haven't gone through the
whole list to see what they've got. I used to use a nommu arm board, but the
linux kernel broke it when converting everything to device tree and not
regression testing it.)

Buildroot also apparently has an LTP package selectable in menuconfig:

https://github.com/buildroot/buildroot/tree/master/package/ltp-testsuite

But I haven't tried it...

Rob

P.S. I automate qemu testing all the time over in toybox, see testroot.sh under
https://github.com/landley/toybox/tree/master/mkroot for an example.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
