Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CE5C43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 11:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782818264; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=SWOnuS0GhQ0PDoRN6gBn918Z7vnC9bCRq/TOtwN9STHrpiOboNlvbPzAbLFRj4AtHcj4c
 Zp4YU6Aj1ZKDxv3RZ/08h1hqzbT58BS8KreIukSq6aG3KeI2Jk1gEhjX+orZ/xekgJkx08S
 Vn47Ael8+Vm++y4wrTxqq/gimAPEso8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43CE23E4C25
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 13:17:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D79D73E4B35
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 13:17:23 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 706FA20097C
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 13:17:23 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493a548fc99so12164735e9.2
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 04:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782818243; x=1783423043; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=MODaQoAS29uJnQsz2Y8D7gWV7eMRcbm0mxsPG+5bvYILc12nxDuRVlUS3PtykNDRXu
 H0DrdkMU/BL+DlasEmmenEEreExVWMIrWBF7O/lW68OW+CfLURyyFXcZAZwHL/ZO+515
 kivPfORm+dcexSwj7zwJhCtcS+QwLzNgyUeaYAaFn1ZI0wp+lKbZuYZKO7E96UcE5G4e
 Nk0Xdh76lkcidAvC8x72o8grZkb5J4kJg6eiqfDwsUVHkUkEgB7Y8vqmF2/Msz2HL3/n
 Ue0nfdTZdHuGz+KEgZBPq/mfi2B6Lji0roAfifUlUNQh4optZGD0rRlBaXXy2cNXKEDK
 la5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782818243; x=1783423043;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=BZ2xkG5SZFG71YMUtEcs2+S7sP065paQ+5cs+wbJ06WS7SPZaP4s9dgaYRUIVJyzZD
 Q2MSYBcIyKBG0qt+FLK2rF9qO7wDM+ng1noizvo93MHTC9cREDKJGcjULFMyIhDMvwvN
 nd3eRYirb0WdpCb6w/kzQHq8nTjsHzYiMlT8VDpH0BxvftJYmidYJeYkY3TRbxTDdMut
 k94ka6K+YJuVBRNhctBYsrgtIwxGoxVWfoe5gBwaaCwqPDQ9XyW3IpmGUbxqiuqxR/Ud
 SRdfd957+rxcSGzpj3wTYq916KAECVH06o2bf5XenPitNC4BlX9cHSFeqNo46Rd+M/y9
 NU8g==
X-Gm-Message-State: AOJu0Yw56SQzZ3qpZUQtBeFfrXFqbq7Joh97owjbIpAvvbrxkXYxz13V
 PPKMR8MLVqg/QOG3bnPkvIST8IDUwDErA2UlrKjFL1ytRvTxERrPmOmPG+XbI2MOHz6QhGvf1Lv
 01xSZcWi6XA==
X-Gm-Gg: AfdE7ckJwCGRSagf468LC/D23w/nfaATMhjHhV+XlHKBbIoUEF3lJE5P60KXlUEh1CN
 iFfwFPHfJuTQTjPUXmMiS6U5A3IGc2E4NzAgxzbeRd9NxBZO9HtUYI+N90kncexAMOzT+Kgj38+
 4Wvn356Nfc83URhzLMYry9fEUqWZh9f3wYQQc0r6A0rPyccnJtx72R2amceepLdvIFD3qX6Spq6
 VHhi77bUU+NL+HSZmA8KC3YJ96OivOAOtb1DCqPkW1Pf0NVlodUto0hT+1CeMX6gv5skJnxmpQL
 7a7Hek1P5cza/29fSVpAo4f+oGXJFo4MBqihrhb62dsRAvh2wpNPpqnPpxi0Rjsj7LAm/RX5EwJ
 HlbVovNsjAUb7a2yklmbjlml02bTMtzv08J7rkKu1y3GHGVXpV+jfOxN93K8OvJIghcpLl+IKKC
 O+a39UZAKR4FwOla2yglmyg6qob3I9skwxIHp7Z8CsmNo0mwT0uecXlglo+HK74Q==
X-Received: by 2002:a05:600c:4ec8:b0:493:b750:bd20 with SMTP id
 5b1f17b1804b1-493b828e115mr51926105e9.15.1782818242765; 
 Tue, 30 Jun 2026 04:17:22 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8d04907sm69225555e9.9.2026.06.30.04.17.22
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 04:17:22 -0700 (PDT)
Message-ID: <6a43a5c2.615e4671.230dfa.ab48@mx.google.com>
To: "Avinesh Kumar via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260626135347.48218-1-avinesh.kumar@suse.com>
Date: Tue, 30 Jun 2026 11:17:22 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] set_mempolicy: require CONFIG_NUMA
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
