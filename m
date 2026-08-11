Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29319C5B56D
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 07:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786431690; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=rsHY4MhoL3ikt72r6saGejgaShL2i4uYroTNs7ucLMkhpI6X1reqBDnDQHx2qy+1RtLIp
 GVMD3Mka4dkI0GJhyleE3+DS7UvNT5t7huqCwpmiSGuLdBkaoTv11iumEp2QmEHHnAcFqxD
 184J6H0OokN+XjEpujZ97NtbZ9nde/E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C26C3D0630
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 09:01:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 545343CBE80
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 09:01:09 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8DE9C1400048
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 09:01:08 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so2226327f8f.2
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 00:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786431668; x=1787036468; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Vdhfn1/6uCebJmrbKDkUJ3g5DorfHWGr+LVAAbMc/WI97TgafATLMcWz4fSO7tW3wr
 F+rk00Z91RODz/9JPfgAwrxXthcPhD9uGymqslU1Mu/q0bwpVxtpHhzibJxHPV35LdOh
 +upvqJH1yaQNe+dtKX1+r67CXQYlhb0RFc3x61bv4IXp8m70sSLBAryI2K03D6d3DU2z
 28Fl0MIUCSOEl40AmWJrK9d++M7+azqlkuSrI2on16t/mSidZUkEp28hBF1EZIdPHXUQ
 B9JAsB+jVLoDQ/tDP+5KHUTg4hru5E8WayAnBAT1Znp+n+F//VXEaJuwFdMxKs3thtZq
 z0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786431668; x=1787036468;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=fKP1Tm3QhnbK36bOgpTEP+a08TkSjsvBEWUO2XxwJ1rUteKAnbOiFbWfaU0Tzhg9oL
 HwrARMijOmnMbttu/tw/dg8LjfTbehqfp1UkKzX06ynmRpVhX5rGi0N2XUvcl6ZffZCM
 wr93y+vpqLd/cdnvWFqCt7tbagPzTSsD1Dfk/OHTvkQzMQk82LaV78kDEQ5wguPvnP8q
 K7I3sTygfgLRYyrrav9Wu3FMU1oexG6NKI9sXX5XgZFN1YX4CTkx1wS31rh8BQcNk7jO
 pN/zI06fqo5H6VpE0jdF0g7tC5eMRN3FFvrfkDULRnLVCPeHQMLSP6J8oYPm7bzZr/yG
 4iQg==
X-Gm-Message-State: AOJu0Ywi9aTTADAlvxae4wF6MXl9V5o++sL9dYKYT1+PEjYydKEpbHzN
 ygKvxsfXjKb6wwzOl6naxa0Olh8nS11csAFczfcIsNz662+kFECoZ/nb7Pq5AKIACRY=
X-Gm-Gg: AR+sD11NVBemUalPq2+0Ilf9eMECCtJHNTNwX54D1PjmDpHvvp12AgbFi7eTIC7kRIz
 X+mXM52Euv5aJfgB/0/DxtYfzXQg4UDyxntvma7KEwhiS+W5Ecxc/vqIJend1l2PSOAcH3XqN5d
 zfqHMA0ZYPdjSB38J4qoCC+oDxuQeEgf5zIUPAc3sMbQnjZS3DsB77d77oEP4CYx/6URsxigyNX
 SFsQZHrxX+HcyPeUinDiG8uqTmpsHQ+2SShIp24Ce2F1MjU9dQxEMalkACZRimm0N4jl+zPtGKb
 93qmDQZfr+FKkFdeSfzTq+sMIMUIaJ6fGVclJh973NMTbeslwN8hP/dnt9QENn94k2Wshdce8Ek
 l2e89u7ciSr6p2nhPbmIZqpGIwOoscgqa3L7UiJRb0/HUiNNaW3R6Ji4eoe2EmUOnExbJzUxkPz
 SAc+BSaXxdQoUEHFLK9KKrlr/1csDDOx3H/8595HMMMiAQ1N3u/+qnyp+txb5xNDUzY23UqA==
X-Received: by 2002:a05:6000:461c:b0:47f:fb2e:f63d with SMTP id
 ffacd0b85a97d-4814ad8c26emr2088539f8f.9.1786431667687; 
 Tue, 11 Aug 2026 00:01:07 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a72cea1sm2114258f8f.37.2026.08.11.00.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 00:01:07 -0700 (PDT)
Message-ID: <6a7ac8b3.be1895d6.181306.c7cd@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260810160048.1040517-2-pvorel@suse.cz>
Date: Tue, 11 Aug 2026 07:01:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/7] tst_kvercmp: Factor out error handling
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
