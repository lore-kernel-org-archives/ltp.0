Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510BCE77188
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 01:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734572996; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=BrL3mKhSS+bFfyEfrvgctGvDfbBu8TP2FPxU4UGYkdU=;
 b=iWIIF5G9K227eqxlHnyJh+h8WjjSUId0jWqf+zk5qfFWx9LPuOT6kKmIpUoFyCNgLzMiW
 cXPIBv4yucM1ch2/BuTPCAdFicbEVTvRwBId8LnqHowlFo3Oor2G0/EqlB2qF/sYRdiApJi
 QeaPacFny80mYnztUDSWIoSQRuSUG/M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 390A33ED79F
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 02:49:56 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A36193ED762
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 02:49:36 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 929B51B61532
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 02:49:35 +0100 (CET)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa66c1345caso23139866b.3
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 17:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734572975; x=1735177775; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=K0DL9FKS21pfaPL12pB+9TVqwRpkTFZF5vB8rleHwlo=;
 b=gGkMb1DOCkWBYeUyOZ9CRHTUro1qAArT6aKYIjEsVrrpD2KVkiLwDOhHu6WBTKkGy2
 Vvfygvr2NkFJq+ywWUGfJQyuHjbLy19OGKmFmUhBjwREjb9m4eNOKoJiNpe6xUCmndqb
 jyzKAmNVQx3bNAzrNE6LtRsM+B5rJf2c68k+xW+wbtSgzQN7Fs21llF7pfD+WAKnhi1X
 wruBgmYH6rBK++giv1d/YNpMcxND9keysPQ78s/WVZWM8rWf3FcdlgAHeyKB5M/1pfDL
 9gN6jZukvyAUMV/wibKDerK5sgRFYME29bqsZI9CYzJ1jcSvLuwnEF1NdrUrthkzZO+3
 n59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734572975; x=1735177775;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0DL9FKS21pfaPL12pB+9TVqwRpkTFZF5vB8rleHwlo=;
 b=aaXbWqFA/R1MMP3PnrcogiXMMaKBZ5FLa3ekoYK/0gy3Cy1HNB4DH7B5yQPit3XRCR
 OMJ+Wjhco4Dvs2DpAUCNdn0QQu4LDGKUTIx0WOTeIQzVY816vhmINLV5/kBwLLXmb5Xn
 tLV6cfQUyQLel12EaM4eRqGKQTkLUtDbaWIzZZM5JACIfLfK/6t414opL4la5QKhCQJN
 lk3tBsE1zta027mwYbIthgyez74ykJylAKgE3rJH8iQ7qiEyOQ2Q+XyNGnmD19+9fNN2
 lI+BftXJLMFM2A8Lo07w8HfitRc9/LEdItbRipxoqKD2rx0bQYOXS/vaHWSeOVfeM3X0
 lBsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS1o2BnNTJ6FiPuk4NTY9LzI28FopheUTj0X1dff+dWQhQELiuckmNH13ipR0Xf9X0Ss8=@lists.linux.it
X-Gm-Message-State: AOJu0YxTUdHC5Gw1ZHUqoNe5piCcRRN67AAauzLegMxJxXt4u4fPATl4
 bQNbMl5+gCn0g8E4B+5VXgMmUQtxYRi72j6VBR1S2Ok00QGjrEF6OzW1PQAYsg==
X-Gm-Gg: ASbGncslko+7rsi48/7KG2Pr1IJWNsE1rxlP2T4eS/bITMti9sQnMYV2RBSMSYpdw+/
 Fro/NSCHB7+9RtFlBkl6LI3w8tTTUyn+NWVn/6EY1CEsX9xqNO9sLzUra9mQmVceD7WJHX57tLt
 QtM+scfvEtsr8O1Dqht6H5/GMx/sjD+G/GKKmUQfXWD8gOn+QmqUtpceIYKgn9ZI9LoETztvuhQ
 0pGly+4XYeJvpdlidZeFErc43ZWUfXfPy5O+rfy
X-Google-Smtp-Source: AGHT+IHFEZs74uaefEUcE14ybwmXgpPhFlic70V7J5NnpDVgqTIGHBAuweWcvsGktOPXMRiwbjJhfw==
X-Received: by 2002:a17:906:e212:b0:aa6:8a1b:8b84 with SMTP id
 a640c23a62f3a-aabf4956e96mr458269266b.57.1734572974743; 
 Wed, 18 Dec 2024 17:49:34 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e89617bsm10588966b.76.2024.12.18.17.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 17:49:34 -0800 (PST)
Date: Wed, 18 Dec 2024 20:49:27 -0500
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <Z2N7pyspF1lBuSeT@wegao>
References: <20241217145041.44600-1-pvorel@suse.cz>
 <12583012.O9o76ZdvQC@thinkpad>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <12583012.O9o76ZdvQC@thinkpad>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ip_tests.sh: Iprove grep count
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

On Wed, Dec 18, 2024 at 06:37:26PM +0100, Avinesh Kumar wrote:
> Hi Petr,
> 
> On Tuesday, December 17, 2024 3:50:40 PM CET Petr Vorel wrote:
> > Some systems have already defined another route with src 127.0.0.1,
> > therefore more exact pattern is needed.
> > 
> > Also 1) escape '.' (dot) in regex 2) use '-q' instead of redirecting
> > stdout to /dev/null.
> > 
> > Reported-by: Petr Cervinka <pcervinka@suse.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> 
> Reviewed-by: Avinesh Kumar <akumar@suse.de>
> for both the patches.
> 
> > ---
> >  testcases/network/iproute/ip_tests.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
> > index ee9768073f..0b1d5a85e6 100755
> > --- a/testcases/network/iproute/ip_tests.sh
> > +++ b/testcases/network/iproute/ip_tests.sh
> > @@ -179,7 +179,7 @@ test5()
> >  $ip4_addr via 127.0.0.1 dev lo
> >  	EOF
> >  
> > -	ip route show | grep "$ip4_addr via 127.0.0.1 dev lo" > tst_ip.out 2>&1
> > +	ip route show | grep "$ip4_addr via 127\.0\.0\.1 dev lo" > tst_ip\.out 2>&1
> >  	if [ $? -ne 0 ]; then
> >  		tst_res TFAIL "'ip route show' command failed"
> >  		return
> > @@ -195,7 +195,7 @@ $ip4_addr via 127.0.0.1 dev lo
> >  
> >  	ROD ip route del $ip4_addr via 127.0.0.1
> >  
> > -	ip route show | grep 127.0.0.1 > /dev/null
> > +	ip route show | grep -q "$ip4_addr via 127\.0\.0\.1 dev lo"
> >  	if [ $? -eq 0 ]; then
> >  		tst_res TFAIL "route not deleted"
> >  		return
> > 
Reviewed-by: Wei Gao <wegao@suse.com>
for both the patches.
Thanks
> 
> Regards,
> Avinesh
> 
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
