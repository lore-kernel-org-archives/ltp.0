Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB52FA3741
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 15:52:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89EA13CAAEA
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 16:52:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A58E3C0134
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 16:52:32 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B251C14002D1
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 16:52:31 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 028F01F45B;
 Mon, 31 Oct 2022 15:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667231551;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mb74tWs5dyvQ5Z1RooR+ysJ4lUWoL9sjFQp5g243d5Q=;
 b=hIBvMyjy2tRo393VtO71dx+0g4PYsrpxLhOi7aIOdRcIdq5yecCD+y0L0ftNm+8LfFS7JC
 tTuu/N9aCTTf2aUTvzi7Z7zl7l7yLTq52p4s7MOusfk02FDg/g+WdrB/yahmv17qsuyVZJ
 SdujqFNFoZgLkN63bEvKDMzMumubZ4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667231551;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mb74tWs5dyvQ5Z1RooR+ysJ4lUWoL9sjFQp5g243d5Q=;
 b=hCN3VN0flNLshKA3gcWAgj4Lz0wL6tqvaMW2se/8OkldWBATy0cFDxz6Bn8t1pT94RvQlC
 C+u5UByzY46v6jDQ==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D7CA12C141;
 Mon, 31 Oct 2022 15:52:29 +0000 (UTC)
References: <20221027181531.3686476-1-edliaw@google.com>
 <Y1+PbX7fYqMR3iXR@pevik>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 31 Oct 2022 15:51:54 +0000
Organization: Linux Private Site
In-reply-to: <Y1+PbX7fYqMR3iXR@pevik>
Message-ID: <87pme8at3c.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_cgroup: use tmpdir
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Edward,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Although it's oke to have 3 lines duplicate, it'd be better to put it into
> function, because we already have few places with this code
> (_supported_fs_types.c, getcwd02.c, filecaps_common.h, openposix: tempfile.h).
>
> I'm not sure myself for a correct place, maybe some file in lib/*.c, which uses
> tst_fs.h (maybe we could merge some of these files which contain single function
> into tst_fs.c and put new function here).
>
> I'm ok to merge it as is and find correct place as another effort.

OK, pushed with added whitespace, thanks!

>
> Kind regards,
> Petr
>
>> Use tmpdir instead of hardcoded /tmp path.
>
>> Signed-off-by: Edward Liaw <edliaw@google.com>
>> ---
>>  lib/tst_cgroup.c | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>
>> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
>> index 6c015e4f8..458b823f2 100644
>> --- a/lib/tst_cgroup.c
>> +++ b/lib/tst_cgroup.c
>> @@ -290,7 +290,7 @@ static struct cgroup_ctrl controllers[] = {
>>  static const char *cgroup_ltp_dir = "ltp";
>>  static const char *cgroup_ltp_drain_dir = "drain";
>>  static char cgroup_test_dir[NAME_MAX + 1];
>> -static const char *cgroup_mount_ltp_prefix = "/tmp/cgroup_";
>> +static const char *cgroup_mount_ltp_prefix = "cgroup_";
>>  static const char *cgroup_v2_ltp_mount = "unified";
>
>>  #define first_root				\
>> @@ -645,8 +645,12 @@ static void cgroup_mount_v2(void)
>>  {
>>  	int ret;
>>  	char mnt_path[PATH_MAX];
>> +	const char *tmpdir = getenv("TMPDIR");
>> +	if (!tmpdir)
>> +		tmpdir = "/tmp";
>
>> -	sprintf(mnt_path, "%s%s", cgroup_mount_ltp_prefix, cgroup_v2_ltp_mount);
>> +	sprintf(mnt_path, "%s/%s%s",
>> +		tmpdir, cgroup_mount_ltp_prefix, cgroup_v2_ltp_mount);
>
>>  	if (!mkdir(mnt_path, 0777)) {
>>  		roots[0].mnt_dir.we_created_it = 1;
>> @@ -693,6 +697,9 @@ static void cgroup_mount_v1(struct cgroup_ctrl *const ctrl)
>>  {
>>  	char mnt_path[PATH_MAX];
>>  	int made_dir = 0;
>> +	const char *tmpdir = getenv("TMPDIR");
>> +	if (!tmpdir)
>> +		tmpdir = "/tmp";
>
>>  	if (ctrl->ctrl_indx == CTRL_BLKIO && controllers[CTRL_IO].ctrl_root) {
>>  		tst_res(TCONF,
>> @@ -700,7 +707,8 @@ static void cgroup_mount_v1(struct cgroup_ctrl *const ctrl)
>>  		return;
>>  	}
>
>> -	sprintf(mnt_path, "%s%s", cgroup_mount_ltp_prefix, ctrl->ctrl_name);
>> +	sprintf(mnt_path, "%s/%s%s",
>> +		tmpdir, cgroup_mount_ltp_prefix, ctrl->ctrl_name);
>
>>  	if (!mkdir(mnt_path, 0777)) {
>>  		made_dir = 1;


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
