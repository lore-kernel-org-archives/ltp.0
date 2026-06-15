Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F41CCD98DE
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 12:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781528317; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=lsT4G0QIFsxmnvjx7Vn2OGNwHyoiGlEjcS1toL2mJWI=;
 b=VQAI6+ilv2grPG4mUd9WNVDXJJlMAcvdOPWgarBajuSt3keAMjHADP/GV1Q6YbxLt0W08
 rWlkyGufCOXkeriu/9CflgHeoSqbUt5NXcKzhbbTUphntqRnLIunIsIkYSyd5vCK8ScYbnX
 XHNpsI+g/+NU6LWX7SVOEOoh7TnZtc4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FBC23E5C28
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 14:58:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D41563C12CF
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:58:17 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 137381A0027D
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:58:17 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49222b6e871so19289515e9.3
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781528296; x=1782133096; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=QXXyKM5WyaUOdemDa1eK5OrkLvqYKMKZVKDyhAgiF5k=;
 b=OMYgsSpWtm4WVQeek9iZkTGI/8uUfLl2pqhtQsyoEj488FP4RhDuEie74gczuOpUW+
 GLKjxLJI2nqtriqsZJlmPkhWDDqSeW+Eu6tqAspXps3Cmz4iUvD0Ho0RjXIhOcCSJ5Dk
 /HaR+Pnagpz6o/5vpHUdjMqIPHH6xysKqExf27DQ/ywOJQsSit+0z6ux3z7y03V4/FoB
 R7T5Xw2xzlUeeBiRT9ePn2wcDamjvuCc6JVfWK9fGNDSk5nXw/pu2e4ELEAAz8jSfyZe
 sGzWt1pzysgle7xEmANeb2bMPYbqYZWDBVXW9zC4KmBAQhI8F7oPpo8ql+NWyFCzKbuL
 RpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781528296; x=1782133096;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QXXyKM5WyaUOdemDa1eK5OrkLvqYKMKZVKDyhAgiF5k=;
 b=GqdZpZc0875bFXs8khC+9/9OzH9m6T0HlwEdcBAz+MlADZoa1MrCorxhSZehTbjSa/
 Kp2XGPxO5hyc9uKKp4AE+I4p7gI/AQvw37CmsSabxcK9UfeHLVIFiw/+mLuw2cLoQt21
 +BNMUIpm4btPOAZ7yWvaLoBAYf6bUzr5JJndHvC5Pj50lZ72vu1bHrxDANoidrZau/C+
 NoGpStXhK2PCYXrNc8auEADGeKzcLsQtZQNbKsdbTy5QP0q63Q9Jg8qxypQSiULpy6jm
 8AAVrqiuyHl8jlK9BjnHl6tEW2HnOaV4gsLv+tp9YB6PYjWwLTM20mrmFq42BCoBUwyA
 rsIw==
X-Gm-Message-State: AOJu0YzUp1TLiZD+NvTL7kz01ibRwCKyVM3aoj6kJsXwLAU8DR575QP1
 tirEhhRONjQeGYbmVwDos04hjUTDZmtsMLvxmbCfml9BcJEIkr1wzEL6Egt49Pr4Af/v5u6wf3O
 3reTKo15eGg==
X-Gm-Gg: Acq92OGJKpkYl8osfFpoB3PJrp3ZqrGAQz+UAOxultxABYqLfA8Chbwx/guYSybxpEv
 Kc+O6FQ9BM6CAYgGgWBgAZahcjYCcroScrZGHV41hNOf0mVZynuY+WlcBoL38sNtYwennjVlO9e
 0L1ZjXAGgbcR1+NuS0XYmlUnLUXhdznVZbSzWl64RJDNrO31DFX2SEWylmAUgbMgaS06vmP2lrn
 t2cfdtE8u37yPKZsYcchyb8aedDdcbczduhjqElKJTybRQHJjT9bCxWmdFpCr1+Jfkgj1kLbdrN
 T1nsP0HQVbcW8Zm52yRXbASRRwDGZ+I0Hd5dVHRhlnwdrOE/7GqKBDkMs9ojkfsiil+5fjVGQOd
 rwr1/07Zlcprk+7dZ86KLlNTQR0GymaKs3Qa5XtexxmUcUMb/2yL/SklGyra25jGBAsTI7NW+/G
 uY1UQ+i3j6XCdORfOvfQKv4hig6dI/QTikKbXpNUDR8e51ftq6KnzGrwNuj7r2Vh8YEnXRqZj07
 C9bEaq1Gbc=
X-Received: by 2002:a05:600d:6454:10b0:490:be78:1861 with SMTP id
 5b1f17b1804b1-490ec4c61e6mr136997255e9.4.1781528296342; 
 Mon, 15 Jun 2026 05:58:16 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea9520f9sm202409815e9.1.2026.06.15.05.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:58:16 -0700 (PDT)
Message-ID: <6a2ff6e8.9499cc59.22cc5c.d648@mx.google.com>
To: "Sebastian Chlad" <sebastianchlad@gmail.com>
In-Reply-To: <20260614174759.24546-1-sebastian.chlad@suse.com>
Date: Mon, 15 Jun 2026 12:58:15 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] io_uring: Redesign common helpers to
 follow liburing API conventions
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sebastian,

> +/*
> + * Generic SQE fill for read/write family operations.
> + * Does not touch user_data - caller sets it via io_uring_sqe_set_data64().
> + */
> +static inline void io_uring_prep_rw(struct io_uring_sqe *sqe, int opcode,
> +				    int fd, const void *addr, unsigned int len,
> +				    off_t offset)
> +{
> +	sqe->opcode = opcode;
> +	sqe->fd = fd;
> +	sqe->addr = (unsigned long)addr;
> +	sqe->len = len;
> +	sqe->off = offset;
> +}
> +
> +static inline void io_uring_prep_read(struct io_uring_sqe *sqe, int fd,
> +				      void *buf, size_t len, off_t offset)
> +{
> +	io_uring_prep_rw(sqe, IORING_OP_READ, fd, buf, len, offset);
> +}
> +
> +static inline void io_uring_prep_write(struct io_uring_sqe *sqe, int fd,
> +				       const void *buf, size_t len, off_t offset)
> +{
> +	io_uring_prep_rw(sqe, IORING_OP_WRITE, fd, buf, len, offset);
> +}
> +
> +static inline void io_uring_prep_readv(struct io_uring_sqe *sqe, int fd,
> +				       struct iovec *iovs, int nr_vecs,
> +				       off_t offset)
> +{
> +	io_uring_prep_rw(sqe, IORING_OP_READV, fd, iovs, nr_vecs, offset);
> +}
> +
> +static inline void io_uring_prep_writev(struct io_uring_sqe *sqe, int fd,
> +					struct iovec *iovs, int nr_vecs,
> +					off_t offset)
> +{
> +	io_uring_prep_rw(sqe, IORING_OP_WRITEV, fd, iovs, nr_vecs, offset);
> +}

I'm not an expert of liburing or io_uring in general, but aren't all
these functions quite redundant? They mostly do what we could simply
do inside test with 1 call and 1 argument difference.

> +
> +/*
> + * Set the user_data field of an SQE. user_data is returned verbatim in the
> + * corresponding CQE and must be unique per in-flight request to allow correct
> + * correlation of completions.
> + */
> +static inline void io_uring_sqe_set_data64(struct io_uring_sqe *sqe,
> +					   uint64_t data)
> +{
> +	sqe->user_data = data;
> +}

Uh? :-) same comment.

As I said, I'm not an expert on this technology, but I see that we are
overengineering something that is so simple as a 1-argument-difference
or 1 pointer assignment.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
