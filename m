Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833F4CCFA18
	for <ltp@archiver.kernel.org>; Sat,  8 Nov 2025 12:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762606718; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fYp913Rt3QX8dLPpyEhpL3dbo/uPa2pQC6eHhGdW8KQ=;
 b=ihtSnqOM68gRekaiHvsOVI1ksyVizXkeR9yADRc7a1vIbHj+MoZQJMERT1rNKKRPTfhVV
 Tw0DMVLnXEbWRbX9Tb8zc2lBAkku6nZKX3adWGvkofoEKTZ9b5sOw6Ikmaujlw7SHQrfhNq
 gyNPFzLXNkRB/MYjrXs2mzMvRE4Y3HY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C75D33CF294
	for <ltp@archiver.kernel.org>; Sat,  8 Nov 2025 13:58:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6F653CE6A1
 for <ltp@lists.linux.it>; Sat,  8 Nov 2025 13:58:18 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1E3A3600789
 for <ltp@lists.linux.it>; Sat,  8 Nov 2025 13:58:18 +0100 (CET)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-64166a57f3bso343976a12.1
 for <ltp@lists.linux.it>; Sat, 08 Nov 2025 04:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762606697; x=1763211497; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zPkGEl9nl8N1gAAuU0Ahi35Uf7rLll+NhMDm2H65dh0=;
 b=Kkkj0nNmVdlQ/ahPMm4ROpGzmtoum6YcR+Xh0H/0NBu69ScDXHeQHJDk8mTDyHG2kV
 fjq/6K39MidksOT6K5+7IIAuR+R5XkQ2xEL9wNf9l6IH0ORrLJmRV4PHKsU68Dk1x+IE
 HYrEEBZiieUvykUzpUM0tvBpsOSN6uYVKQnV5Bdv3kC0LkSA1KlxpK6sPaOs3SFuIW/h
 1aKNEdhqnYkB0/COx2Td5JU78S6J+qXi276W4ZiDJEr7OBNHPajj+gsYF2EdN74aX8+E
 GRBnUgujTs3/T1zxot+695d89ix0b5M5hNdIFdUcZxl2MAnLjUIhMQUWX7On6k7/G2Zl
 yy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762606697; x=1763211497;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zPkGEl9nl8N1gAAuU0Ahi35Uf7rLll+NhMDm2H65dh0=;
 b=GWf4pRwbU+xyY8bQQ7AR/jeGtWrH/puXt1YtP+aZAtqkgBPZsD+csUMZcSP9y3N0ay
 8hvfwdfy1uAcPVZcj95dbdcMmKfqC/LX4DfJ1QYRnV8XFPcfi33WCXV6RAwNgKWxQ8ek
 ynBJdfg5E23NzVNaYbelUD+5VjiOWn4PLgn4l578fyO1lzKvRCMAkYaCo1kNREp+7jF4
 8Vzkm1RzbgjHgW4Gmpsvh/M8tSHSJxTLhQCiHK57nwhcW0p2xbTAGyFhi5kTolLO5Ok1
 j/QFx7hcQq4Sr7QrnIvCoLFtGMQZksEHGJ+U369WUsFVtLYKUPmlLtIuVDK0Xk1sFzmg
 66Fg==
X-Gm-Message-State: AOJu0YzY56NHDQJ8pZZGZ7cYXFL22mGa/v7O01TUYsG983YYZDguZqX3
 WhfykmLtM/MuUkA4TVDvtNmce0n81L5p7XyhAqP0neqogz8a7GSfV/39lSOHxvy+GyffhO6VwW+
 4jKc=
X-Gm-Gg: ASbGnct8pvwy79u6CEtYMrcYJm023iGYd0xiJjwArjeYLdBaBGXBtR5ZHKLShxQjY79
 zR2zhGESadII5IvwpbNtqZn9cD8R//rYnRh4BeiOsbwKqDaXRb4Oj7BX8VdhBICdrgxo+rHT62+
 pjE1uq6D2+wllEL00eWw33haJLkD43I4SA7i/L9ZTzaTWE+GZXcNqeTFeJF7zbVvg5SRIY04/HE
 vvnbEl2nj8/TNKxVLRatCqCX8piVkvux2Q3BNko6RBDrbQNg0vyQhRfPQ1gbkeiSCCF+POReu/z
 hmL0FGXWjstagl45eFQ/rpHUIKBOwq5oauPU4KcBFkoC8y/yel3s0gZQlelpDQpyiKjCSphiY7q
 2G+wu+BQlaGSc8L5QV11vcJA26l/k9tfWyOFU6HNYGGQkdS8PPw/g+q9lYQt/0wPEVXzqNjTbGQ
 jJnVmyCg6yNWIV6KRlcMR8Nw89KlnI
X-Google-Smtp-Source: AGHT+IFRstyzF2ZpVmU5urtSmkQCDnLOpbwK51zWVMeQf9PA/aVubtehO6IDiGJh68OjS7R7SVdTEA==
X-Received: by 2002:a17:907:84d:b0:b72:c261:3ad4 with SMTP id
 a640c23a62f3a-b72e0410a5dmr242686966b.34.1762606697404; 
 Sat, 08 Nov 2025 04:58:17 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bdbca75bsm542109066b.14.2025.11.08.04.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Nov 2025 04:58:17 -0800 (PST)
Date: Sat, 8 Nov 2025 12:58:15 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aQ8-Z59Agmsl5wwI@autotest-wegao.qe.prg2.suse.org>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251107003041.28929-1-wegao@suse.com>
 <20251107003041.28929-4-wegao@suse.com>
 <20251107110421.GA1116063@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251107110421.GA1116063@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/4] ioctl_loop01.c: Add new support .needs_cmds
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Nov 07, 2025 at 12:04:21PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> ...
> > +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> > @@ -78,21 +78,7 @@ static void check_loop_value(int set_flag, int get_flag, int autoclear_field)
> 
> >  static void verify_ioctl_loop(void)
> >  {
> > -	int ret;
> > -	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
> > -					"primary", "ext4", "1M", "10M", NULL};
> > -
> ...
> >  static void setup(void)
> >  {
> > +	parted_sup = tst_cmd_present("parted");
> > +
> > +	const char *const cmd_parted[] = {"parted", "-s", "test.img", "mklabel", "msdos", "mkpart",
> > +	                                  "primary", "ext4", "1M", "10M", NULL};
> > +
> 
> dev_path => "test.img". With this you're effectively reverting your own fix from
> ba605cc955 ("ioctl_loop01.c: Use proper device for partitioning"). Why?
> 
Sorry, my mistake.
The root cause is that patchv2 was created before the date associated with commit ba605cc955,
so change base patchv2 without rebase trigger this update.
patchv2: https://patchwork.ozlabs.org/project/ltp/patch/20250928232708.24007-3-wegao@suse.com/

> 'parted' with dev_path immediately fails (haven't found why). But with your
> patch applied I'm able to trigger again the problem "TBROK: mkfs.vfat failed
> with exit code 1".
Because missing tst_attach_device for /loop/devX before execute "parted", i will fix that in next version.
tst_attach_device(dev_path, "test.img");
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
