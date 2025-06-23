Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775F8C77B7C
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 15:38:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA6263CCA77
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 17:38:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 379F43CCA6D
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 17:38:02 +0200 (CEST)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk
 [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F018B1000963
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 17:38:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=yECWFHRLSICScsLOODrvX0DQ34E/EbLJe+lPxiG6Glc=; b=TQOp3TGz8kq77hJhTi06F4zhTa
 BINDn/7EKsY/vh/O7xAGtYCBscW3ZlricdEKuWaexP2oytH+J0zniZt6y5vT6HSwBVqRlyWon3v1O
 ly7teNgezkyEmmOK6HlJMr3S8VxIQTA3kOAz+XmYlEuKrZziaYw2OWCxdvhO5NynHbjeu6xgA612H
 AqY4nyKouyk7BBvliLgdGn7juI1A4cadaiD1ZAwokzYLJvx482h/DkF61LV+MQ3UYzwdElEanKetO
 h4UKcBC74sdznTWLCoS6KMeA2X2eJLnt0e6mOnsdpesnsxeZ/OciKEcvjgL2so5HX6JWrY0vOh/G8
 lRURaang==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat
 Linux)) id 1uTjFA-0000000DcEA-0L7n; Mon, 23 Jun 2025 15:38:00 +0000
Date: Mon, 23 Jun 2025 16:38:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250623153800.GE1880847@ZenIV>
References: <20250622215140.GX1880847@ZenIV>
 <CAOQ4uxioVpa3u3MKwFBibs2X0TWiqwY=uGTZnjDoPSB01kk=yQ@mail.gmail.com>
 <20250623144515.GB1880847@ZenIV>
 <CAOQ4uxhTXgTt62cX-F00e4vAyhDn=fCTxDqONcGT9+tBH-DkCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhTXgTt62cX-F00e4vAyhDn=fCTxDqONcGT9+tBH-DkCQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] interesting breakage in ltp fanotify10
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
Cc: linux-fsdevel@vger.kernel.org, LTP List <ltp@lists.linux.it>,
 Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jun 23, 2025 at 05:19:26PM +0200, Amir Goldstein wrote:

> I have no idea where this strange TWARN is coming from
> I did not investigate it, but the bug is there anyway, so I sent a fix.

OK...  Current LTP + patch you've posted does not screw that sysctl
anymore, so...  Tested-by: Al Viro <viro@zeniv.linux.org.uk>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
