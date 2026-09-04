Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CCDC624D3
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788518380; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=gkkekGMRyQSvPRht4+mt03n/PAe6x6niH64MKzY3HYkmXAiC/cYV4DVTIePsCP0GC/IyN
 TH8Y0VrQnJpMqnbVUR7eRUwHpW6HN1aVmNfcMz9rBUFElQrKpdAgNaziiQNgSl6Nc5QYKPn
 FW7RY1UirOCDupvCgaZuRjg0XTX4ync=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DDC33E976D
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:39:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8314B3E939B
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:39:20 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 13A2D1A00211
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 12:39:20 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-482ea739de2so550488f8f.0
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 03:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788518359; x=1789123159; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=g8/LMGNodQfVwq4f61WNiIRQ3fJl0S321n968I6wDHCpwj+fRu1b3Uaj/y3CKlIo9J
 Vy8yY9EmmmHmcOlvvDnaL9nSNgI9bz2O42BoIZowFY+RVd7mU9FP9LaGk9bwyr1JqEpT
 X4eUwMXUprDEap+7OcJEXpm/glzfrVhb4PHGKvwtmD1WsxOXfu+PMoUuN2QLDikN2a++
 5iNz+kntWDVQKazpT1FO8abjx/z3kDRkMI7zH7k9FV40DkN9nP07Hy45ljGvYXtpFKjg
 OInISj37Y0nnwNMu0NowyYA8WwLo+xkVVfuErKXRvxU5CwOCJRiZxGcvzPqnga/I+578
 gF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788518359; x=1789123159;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=WSaZIEs28U3iXioYMJiSNPj6Bsf/lezT/iqbpeaJrFhxRrv9se8XBk1K81TLz3OMtB
 4FOBOEvfQ2vg5j53WMBLKdgk85/Gq5OzYXc/LRkC3coiAMAC+8QEh37W/3CIOwijAumX
 t6Fm1d4O821wVczVMBnaQUSyXTFAyvJGw6ziGWipifamlYlHeBEofEqDRWeXLkNhiw8O
 pECNmvHCMNe6zSyipaO7c7ZeglZ76ce7Dz5LBQfvUWS11gzYKp/+5sxk6rqyhe7LL5du
 Q0syo3i+IlLiOgc8yRtC1cynL9EmwDi64NFsEgiOVewE0TKSBIki7LS96VzEDPt3tf1v
 DCDQ==
X-Gm-Message-State: AFuF++kIhgR/azfXpwL3RPDXvdUrtkEsaulpRXfCxg+R3sDHYUPDjtOH
 SAAlKGrlApCWBK7wbtAh3CWx8XF8cpwNX2nkrIS1UaJFh1DzIY21qv4uM/CkWfCJNERu06oslE4
 KQ4S7XXXNlA==
X-Gm-Gg: AYBFou1JiFQGfAFEvEADj6LvUCy53o6AQspQVHiQyGkb3x8YVwdaPV9eIiwitbSok9y
 GuWLSn2WEyf7nIKOr8bF0tylw9XtPIaJJsOwkwMFHUf+R3dFsjDR0kqH0oeApaliytsMlNKEtly
 KwoqN3gAJUNOPByolzqfP6jlPiMop9suYKrkGa5GCFqDem5qyctQfMvRLdJCc6go81/8hY9S9yA
 AQh2jq/glgf/Kmw4j8JhKepwfwKgMk1Kuljkj7ePVUD8QRKJ14TLLOcNiCFe6YI7/zIp/GeTkPt
 xi0eFUJXS9XRh17Iuao3RUAl6pLD4sHiO6ZJPLZEeuEvu6armyYdv2a5Rbu9G8YP3MxkxkKg80P
 e6jBkBUxiCmMS/v7286OsqjQrVzYtOhko/zbEwME0T+6YruXJmF1Z+feIcYdfjwh457vn2PXPkH
 995+Ar+sTCCUnPi4/HZddtCg32SUbo7Ki5s73PymUL9fxAeqJIu/ogMK/CshS2JIGJTghA3jYY3
 3QvUPnI6zpO
X-Received: by 2002:a05:6000:41cb:b0:485:8c16:a346 with SMTP id
 ffacd0b85a97d-4858c16a537mr2350761f8f.30.1788518359368; 
 Fri, 04 Sep 2026 03:39:19 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885c5bbdsm5064844f8f.36.2026.09.04.03.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 03:39:19 -0700 (PDT)
Message-ID: <6a9a9fd7.b1f9e4c6.84bf5.57f5@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260831020028.19193-3-wegao@suse.com>
Date: Fri, 04 Sep 2026 10:39:18 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v13 2/3] lib: New library function tst_get_free_uid
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
