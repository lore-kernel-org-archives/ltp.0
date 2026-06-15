Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29886CD98CE
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 06:32:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5ADFB3E49E5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 08:32:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E63123E2164
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 08:32:12 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9B0E61A003E7
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 08:32:11 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-91ae31bbaa9so37161585a.1
 for <ltp@lists.linux.it>; Sun, 14 Jun 2026 23:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781505130; x=1782109930; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+6Prhx2pSA8+Tu8AaBxZzlG9uLRGvabVIdTFzg7l1c=;
 b=bsgd8HKpRvxP1H+h4/CQ5bW3Q691Sjl+WaZEqfm30PQdGoXGN8hKjM4R0dB6IGEusU
 7DotMQacQyTVucZKcHlk2ooIugFYDoEmJ14rG97HHz4jfh99yp08vKV53No9NOBdfK1i
 vL0ol/iOkAFLAR+cxXYZWfDlDSyvqCDxYBC4KNxn75IIXBX+riKSxOvqf+uA3q6FvK26
 yjChhbYnv75u9zgb2Anv3pkjKd/bfmliQm9n9J2fk6E9PI4/AdDbB8QJUhGYWQVLv9g1
 irmPfmh219qSDxtSYsGrkz40fKkg4vDDwWAbVuC1DZVOKyECIKt2gu1LTA23TgUmDZMB
 fuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781505130; x=1782109930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G+6Prhx2pSA8+Tu8AaBxZzlG9uLRGvabVIdTFzg7l1c=;
 b=blK3xeuOBxmytj/0q2Ho86D+drR9qDFE4/EfbTRMcQHLOnxg8d845Y7oz9JzSOEW0G
 zw2HxjRTP7R9RvtCJOk2b8AMYxN3l+266BwThZblgFUscMy3qTjii2XWH+AlLTqEXx3N
 Ld6ihYW9HUkI3OkdRF6Zsx4NdNHDVDrXztzpSfNK88Zxe/nmr04AA1tR+IRKJOXwojDm
 dhficopC/ha0QyI1oCO7q6hVC79cTX811J29GtgD278w13PeQ5ay3Y1K4lpClmSHzYPE
 5CpuBS/N83lFyOpIKfVlAhfRh4H8OHi7MJ3G5iBAaAj7yrHpMGErlHa7vAbWa2KRbCxK
 vHkw==
X-Gm-Message-State: AOJu0YzWbfvxvdwl0s1GEHUJnnhwMFXcIxO0+ataGkI9g6ZXONaguzn3
 PXHodIHXTydEtHE1PDqVxv/yY21Ug63Iycw0fZc3V8EENnsmFnINJxZd
X-Gm-Gg: Acq92OEdR6dBrp9Iz6LzvhjaOxAJ3KaJNQLJiebpMmfnDY9G0oy1r/6LKziQKsPRDdB
 +BvDm17y/3qR/klA35FtdpjJ8VO41G3eCmSZi77FdYUqfo1J90WTtqZHpQEWcGjJ/bvjAt+amuQ
 QVJ9ptEA0SGh3lHE4mwJAbzlbgtypzwZvPsXlSHwfv7r+j4uoaH5XZZC/5ee7ZZvnfIui8+GD6y
 H+TAkKzz1vjj7i+3I4OENKfckL1j3Bt1X/JuUdmCz1vt1X2blWHGI1931lRRC/sHbD6mIZeVO1p
 5O+DNB6uCaL/WeO0V2vzj5CukHNlnRutSx0sLgbjk5FZjKnokFUlKgtiSSr1OnAXdwoorUk+7Wf
 3wziAeUIBAahGQKMEqJ1po3c9p4f8jwZpE7Yjemg4rvMOkUuE8mhBKPcyJsIaLCH0gw2jfMLGoz
 8aKtbHQE+McaMoaFWIw0F3bpsXA7iS1e4dQ6Pz+mUYdR/+o6FvRNgSyNUN2A6FKHlmXsaFHOfUC
 P0f8G/9Ws9vee4/Ze00VZFwlROSem3kzYHtuvoh
X-Received: by 2002:a05:620a:40d5:b0:914:babf:9f45 with SMTP id
 af79cd13be357-9161bccc30cmr1907772085a.26.1781505130250; 
 Sun, 14 Jun 2026 23:32:10 -0700 (PDT)
Received: from
 runnervm1li68.3o0hpsufxxkehjtylihp12zn3b.ex.internal.cloudapp.net
 ([135.232.225.18]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91619ed7fdfsm1030628185a.3.2026.06.14.23.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 23:32:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sachin Sant <sachinp@linux.ibm.com>
Date: Mon, 15 Jun 2026 06:32:08 +0000
Message-ID: <20260615063208.4077-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615052953.18183-2-sachinp@linux.ibm.com>
References: <20260615052953.18183-2-sachinp@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fs/acl: Add ACL_USER_OBJ permission test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sachin,

On Mon, 15 Jun 2026, Sachin Sant wrote:
> fs/acl: Add ACL_USER_OBJ permission test

--- [PATCH 2/8] ---

> +static void test_acl_user_with_mask(void)
> ...
> +static void test_acl_group_with_mask(void)
> ...
> +static void test_acl_group_obj_with_mask(void)
> ...
> +static void run(unsigned int n)
> +{
> +	switch (n) {
> +	case 0:
> +		test_acl_user_with_mask();
> +		break;
> +	case 1:
> +		test_acl_group_with_mask();
> +		break;
> +	case 2:
> +		test_acl_group_obj_with_mask();
> +		break;
> +	}
> +}

The three test functions share the same algorithmic structure:
set up ACL with full permissions for an entry type, verify
access is granted with mask=rwx, clear the mask, verify
access is denied. They differ only in the ACL entry type
(ACL_USER / ACL_GROUP / ACL_GROUP_OBJ) and the UID/GID
used.

Could these be collapsed into a single parametrized test
function driven by a struct tcase array? Something along
the lines of:

  struct tcase {
      uint16_t tag;
      uid_t uid;
      gid_t gid;
      uid_t owner_uid;
      gid_t owner_gid;
      const char *desc;
  } tcases[] = {
      {ACL_USER, USER3_UID, USER3_GID,
       TEST_UID, TEST_GID, "ACL_USER with mask"},
      {ACL_GROUP, USER2_UID, USER2_GID,
       TEST_UID, TEST_GID, "ACL_GROUP with mask"},
      {ACL_GROUP_OBJ, USER2_UID, USER2_GID,
       TEST_UID, USER2_GID, "ACL_GROUP_OBJ with mask"},
  };

That would remove roughly 130 lines of duplicated logic and
make the data-driven pattern explicit.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
