Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEBEC83F3E
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 09:08:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A97673CEB5B
	for <ltp@archiver.kernel.org>; Tue,  5 Sep 2023 11:08:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9A553CB78F
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 11:08:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8A5771000DBC
 for <ltp@lists.linux.it>; Tue,  5 Sep 2023 11:07:59 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A9CA11F750;
 Tue,  5 Sep 2023 09:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693904878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfUTWVkg/c3vjpCi/gUS3KB8ZpCws9VM0RS++3xzFRY=;
 b=dR7wPrCysLP/adIM7NsXaZFVlBtrvCYjGWY4Pg9do+fXJ9OdvImTMwcSHMGp/OU2Ins26D
 p7lh4b274AXyh2VF+VcuZBqjlAF6r5oPgfM4rodZji2LuXQbYm0o8ErINHckcRwS2Zu0Vw
 SyyR5KhpyPTyFzhvI5jzbp43VYd+bLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693904878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vfUTWVkg/c3vjpCi/gUS3KB8ZpCws9VM0RS++3xzFRY=;
 b=Gyysy3e+K533HeR7VCqhJXgGN1ttGK+hqrwGdWUn4le1bo63HdBIKjxRyNIEJx9I1cUTQ6
 Qh2ARman+i4woyDw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id AFE002C142;
 Tue,  5 Sep 2023 09:07:57 +0000 (UTC)
References: <1692963336-4007-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1692963336-4007-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <2832137.Oz9D4KcPff@localhost>
 <2778ef59-6d56-ef5b-8274-81f6a25f4882@fujitsu.com>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Date: Tue, 05 Sep 2023 10:06:20 +0100
Organization: Linux Private Site
In-reply-to: <2778ef59-6d56-ef5b-8274-81f6a25f4882@fujitsu.com>
Message-ID: <878r9lf0np.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] hugeshmctl03: Mark struct tcase and
 several functions as static
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

"Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com> writes:

> Hi  Avinesh
>
>> Hi Yang,
>> 
>> Changes looks fine, but I see that there are still make-check warnings for
>> both these tests. You may want to fix them also or maybe another commit.
>> 
>> Reviewed-by: Avinesh Kumar <akumar@suse.de>
>> for both the patches.
>
> Thanks for your review, I have sloved make-check warngings and pushed.
>
> ps:Sorry, I miss your review-by tag by accident.

In the future please mark it as accepted in patchwork.

>
> Best Regards
> Yang Xu
>> 
>> On Friday, August 25, 2023 5:05:36 PM IST Yang Xu wrote:
>>> To follow LTP conventions.
>>>
>>> Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>
>>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>>> ---
>>>   testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
>>> b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c index
>>> 21ec6bf78..61e9704bb 100644
>>> --- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
>>> +++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
>>> @@ -44,7 +44,7 @@ static struct shmid_ds buf;
>>>   static uid_t ltp_uid;
>>>   static char *ltp_user = "nobody";
>>>
>>> -struct tcase {
>>> +static struct tcase {
>>>   	int *shmid;
>>>   	int cmd;
>>>   	struct shmid_ds *sbuf;
>>> @@ -97,7 +97,7 @@ static void do_child(void)
>>>   	}
>>>   }
>>>
>>> -void setup(void)
>>> +static void setup(void)
>>>   {
>>>   	long hpage_size;
>>>
>>> @@ -118,7 +118,7 @@ void setup(void)
>>>   	ltp_uid = getuserid(ltp_user);
>>>   }
>>>
>>> -void cleanup(void)
>>> +static void cleanup(void)
>>>   {
>>>   	rm_shm(shm_id_1);
>>>   }
>> 
>> 
>> --
>> Regards,
>> Avinesh
>> 
>> 


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
