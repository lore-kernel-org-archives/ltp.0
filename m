Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DB0C61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 06:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787813798; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=eHPXHHezm/Ez+kh+JBQaIwlHkXc+8Ss/98bkgbIoSa0=;
 b=a6WFDiy4e/qbB7GAUQ/qC6oskv0PoklWhG0yLZaExIXxv1SPWds0MIXeDP/9+4UNDVgc5
 aak9Nkl+6jMqIMy9V6LujarnzKsBlYbqLxkfli1XqmaQjdGKEjDRIDLH1o7TykNxu+xRD9u
 kYgPnSAv6X8Tp8De3gXMmPx8X0UgePU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D7513D0360
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 08:56:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81B6D3C2861
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 08:56:18 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9305A20077C
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 08:56:17 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-49b8eeb3ff2so432615e9.2
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 23:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787813777; x=1788418577; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=v5KmIwvbWUE3jDucVqJiAQ1x2Uf4Z1+cdU9H7Sqvl9I=;
 b=YgdkOu07HjUW/XfQaRO2Bk3u8OjgGLArcmO7gtCWIY7G4pXG8L29qAcSozr1CAGLR8
 dBbfWt4WJUCFcYmRdFKHmXyWJoZubgyH6XeCZvMpUWPYtk0BLB/tefXvjDhRw4L+IvOo
 mURs9Wz/qe2naY/Z8fxZkl3WuN3jrazUw9ebhr8Vc8MzlTOQwDRQOOW4EqCkIAEfaobu
 ydDEGix+udx9bS/m+43MBsNqIOLgp0TQTtyeYWTkCfTLQH6ijw+TT85EQ6PZKc8+Vnnv
 6x95fM8219OLadBmxu31lWsAwZLEvLJODwpWHlHDtrkgmZxS+Zd5sKPuGkHIcKIijdWW
 jNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787813777; x=1788418577;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v5KmIwvbWUE3jDucVqJiAQ1x2Uf4Z1+cdU9H7Sqvl9I=;
 b=e63lsbzexdX2x81C0UqjfYnUHxnG0zv306EGR5OJSYY+zaic3Y5lEGcZgejobJyScq
 Ha0NgulPSd1T3aQ08Yss0YrhsUiRX48L/vebgrv6YfmGB91CwRBzM3J2NItDLm6iXKZ1
 /4AkqgQKFd/TFBhUe1TenUSuCfFkYAPCkYY8rGXH1nZaNKbVwJ9hW5NmEFKraL35NI5l
 jI9cxe30VnNL3E4OiCg6NUDAZbyR0nGkLhByx1fHiq8St+xRCa15VQDN/hTbnjiiNMIr
 XhlXPHVClUwSKZWXAkHDkrCTG0WNqTG3ynJsTlP2jbepJrH7Rv1WN6lBcJOKsv0/Y497
 2JDw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoD7ATratwvgYrOFKL2cLhjkZGqeagqktVsQuekBcmdSlkjELg3xMwgu9RCd+zWRjUYp5U=@lists.linux.it
X-Gm-Message-State: AFuF++kIlGyLLWXr9yej1BHTfC1YEPgg3aik3vJIejR25l+xhRlVBNdK
 SXObl6iGwmfenfBkKXdZ7RwRpazbAKR4mjxB7lO6rY83KpCPbItsi8e6YwB+MBTYyHE=
X-Gm-Gg: AR+sD102wuIT6A/14T+QlXZYI15UtreRM59lY9JsKNa0++4kvRdWFGfK/JcUUZoYPQ+
 /0WV9dSKaSG1VAYll88zpcZ9GCIoI6QXHCjqN1qPqSce9O6XzWgyPk3aA9q8MIPB+WUHP97HnCN
 8VkcOtsR13+befWYdOkLc7iCiSG+NMBQq54wJrRqbCm+YZ4zN76Wq+ytQWlK5EDqI6q0YceKd0q
 K3SqI4e1IVOOhpaPoxiOwrdKUpa7cou8I6E8LpmJ2MZcLMrprI09KhvlhgpJQI+nKGR7zlWLIt8
 HBYD1rEkSOABc3jqgSkYjnIk+p+l8pXT2gTb4R75iOpWq7ycNJwQgyZG3zSlJ9tlZJxEUPos5fI
 Ayk8/gU/kwG+1vtlakxMg4DF1iAtfXRp8NgMHMyWEtqM76Z6ijLtW9Uhx9x1+bGigtbCTftOZDy
 AuslKbqZtGC4dC7UN2GIfmkxYNj5mFeL0RDhYMxgIW7CNbVKSzZtgFB58x/KLGhtOkIkBcB9EYp
 kvHL2iaOMz0CTX3SWVDUSXbRm9OGuSDGPbviLSFfY08tjp18wMt2TJNyJowVwXqCWHnZ8U=
X-Received: by 2002:a05:600c:1d0f:b0:499:bf0e:95c8 with SMTP id
 5b1f17b1804b1-499dc6e419bmr122463035e9.1.1787813776947; 
 Wed, 26 Aug 2026 23:56:16 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27ab6d0sm6534522f8f.13.2026.08.26.23.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 23:56:16 -0700 (PDT)
Message-ID: <6a8fdf90.52a3ce3c.38dd62.6301@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260827030518.4078-1-linuxtestproject.agent@gmail.com>
Date: Thu, 27 Aug 2026 06:56:15 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima_tpm.sh: properly detect failure to verify the IMA
 measurement list
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

Hi Mimi,

> > +	pcr_aggregate="$(cat tmp.txt | awk '{print $1}')"
> 
> The cat here is redundant, awk can read the file directly:
> 

This is valid.

> > +		lineno="$(cat tmp.txt | awk '{print $2}')"
> 
> Same here:
> 
> 	lineno="$(awk '{print $2}' tmp.txt)"

[..]

> 
> > +		tst_res TPASS "aggregate PCR value matched real PCR value (line: $lineno/$total_measurements)"
> 
> This line is about 100 columns wide. LTP shell style asks for lines
> under 80 characters; perhaps wrap it or shorten the message.

we can ignore this one.

@Petr can you please take a look?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
