Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1493EC55162
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 11:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785409848; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=iQAviK+jnkFJAUn4yDWTyTF/iFcu+7Tv9tdMsynpqlo=;
 b=ED5IJpdKBw9ZltDEV+v4gMJr+sStRKxXsvtk/XdKehz2nYgBhGGl5vWpw5rPIM/Pl6mbm
 RsQawSA/ScYF7NSWWym+uHGYTALNUVZCq80Jh3QFW9bT31DPLrvQdRGbMeguZiJPiYPp3OD
 FQeKG1ZN5b7rlFMFkSMECuoM2CEZVng=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 807CC3E722B
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:10:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DDAD3E1F8D
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:10:26 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BCE0B1400990
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:10:25 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so1793732f8f.0
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 04:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785409825; x=1786014625; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z9U0FcWkSQFQETB/+zukC1pi/tWvhicSFyqdUds6u20=;
 b=KdDNWT5+01pi1oqFdXaxpEkgmBt0pT70lI9N72CvBDtMVZhCLzmvWdpL4rb/bLm3g+
 C1cudkn1KsNa5To0svJe1FKqQE0aEqd6jBegjS7rKGIgPk6ObwiufkeCG8c5s7C1jcgK
 MIt3ODUrzixHeHOFeRQTgLi+t9D6IEweuLRPkhQ8c5SIcdt1iTo+HoAtKMwMmgjlZpbx
 WYBDy1/PnLft3+R3p/K8RQbO+P7TyY+0AlIK+gIzlujUmpQMDicr7HhryxJ2xZ4b/sjj
 FC8+lrLmFR7Sx2f4trVa44YR/sd4Z7ITS7P5GK1MUC6qGHVC2AfmwLarWLJmKaj4AA9W
 VBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785409825; x=1786014625;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z9U0FcWkSQFQETB/+zukC1pi/tWvhicSFyqdUds6u20=;
 b=aGZGyu/vxL7lAt1tgswPpncqhOnY1ZWeOFf0et/WhfDq6V4g6Rqylsvdmwz+JNsX3D
 8WSpH3jXTZZ++YEH/dttIwgRmQ624Y0H0m26VwOgO6O1BBjFmfzimM/EP7sM2SSJdx4c
 dbJAa+93UfR6CkPYnXoug8NAIqaJ9RzpIRIMTllbvPJXCq0EcX+bnoxuzxGUJVwgHDl9
 gN0GctJvWblVqVroKQZ1ZTtVICfkTGWxHH8gkSlqjYNB9PR3jq920kodUsDmDzJdafqD
 WAaCIG+dSQK5a9Ow0uAsbmIqTVAskpciPnuHYtptEEFIObY1Ny4J6FFnqSzqe/jkn8/X
 6KkA==
X-Gm-Message-State: AOJu0YwRCi+gfs+Etc9YhaZP5nudKGXE9X4DmnnBmS0bj4RnjUigvU8s
 xBA4Pq3A+XCOrc/Ctk2lGQPa+XD3P8WqPfGcz4OyysnkpJWdxIh5+D1LYDeY/yt64NtyohpY39e
 fhjtge4aeTg==
X-Gm-Gg: AR+sD10A1lRUk/3x2hzPsPpWWQUCS7NXGOkdwQ8Zq2mnPb9eHDa9t5ej21lG1Rs4DZx
 Up69DR8EXBZyri5Z8sFAmHYPvQYkVTndoVCcWMP+9e3L9xEzOZziCMYtqOdJDGG97mrqM59flPB
 4y1fiSNuMkqHZubUNuNm60HRIEPgKifZ/79SVVPXv37aS0POTCVVeNEVUVpsmPew3rvWqe8T46u
 ZqkcRaJ27gVGxwgR14CyItVibm89WgJ4zhnrAHsUL81AgN0dAeYn2TtwyiCvuMzqhJK37Cqk2Fo
 ltNyS9D8cIC1GkVdSV16TUXyZ/1HVgpjZLWa3uDxYin2QGITENfMHsb1fylbTmTtQQ7apPnSIM8
 QHJKzWqaM06IrG1Y3Zt6gRH4nqN2LI1jQs8DnNAQmQvNPEgB2WHyJoMaf0cJs7KVNVU4V3d7KF6
 qhCOZzNXYRIyMWqkc+wZHW6YaOVw8xkupTG79tO7Ysir1AIDxCRkrL+In1h0V/tvPgr12C9y73q
 AdnPj/rMyda94ENx9UkVAtLSuxR30qtyMGiWg==
X-Received: by 2002:a05:6000:2c0a:b0:47f:83a0:fa21 with SMTP id
 ffacd0b85a97d-47fc820c32amr2983035f8f.51.1785409825100; 
 Thu, 30 Jul 2026 04:10:25 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc89342f7sm5595102f8f.26.2026.07.30.04.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 04:10:24 -0700 (PDT)
Message-ID: <6a6b3120.16149c93.268d1c.58c5@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260715123612.1684984-3-chrubis@suse.cz>
Date: Thu, 30 Jul 2026 11:10:24 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/5] syscalls: Add epoll_wait13
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>		if (fds[i][0] > 0) {
>			  SAFE_CLOSE(fds[i][0]);
>			  SAFE_CLOSE(fds[i][1]);
>		}

It's worth to change the statement to check for fd != -1.
Otherwise:

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
