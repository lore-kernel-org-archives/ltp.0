Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B3B3C433EF
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 15:19:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B26E33C9A48
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 17:19:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A834F3C97AF
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 17:18:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B78292009E7
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 17:18:54 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id BA8EA1F381
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 15:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648480733;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oRk45JJ5mT2r+F3MSLdb+hSQY7alM9jV01kff4gOxAk=;
 b=uQk1KWtghGeLyyWEmoW6P4S5Qg6176t9IsqvyOxEFfYUEALP2wBgWSoYUIwre/hM5eq0n7
 RFW8QE9FwoyC5G/yOkmPdhb4Z9IDeM+4/7XUsqlK7s0IY3uiFbcomM+oODw8LBgjNgdWFS
 Telir4Lc8X/BtQ0uVfh6kgB1inF0gQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648480733;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oRk45JJ5mT2r+F3MSLdb+hSQY7alM9jV01kff4gOxAk=;
 b=ck95dv3OF3uApe+jtBQ9uLKr5EsCcD9Y7o/HQrMLsPRpu46Nvi1J+exrSgT4DNHM6/3XkE
 dC0Bc6hAD2nTj9AQ==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7A3F9A3B99;
 Mon, 28 Mar 2022 15:18:53 +0000 (UTC)
References: <20220315134122.22912-1-rpalethorpe@suse.com>
 <20220315134122.22912-2-rpalethorpe@suse.com> <YjtfTHjUHeHvSTgG@yuki>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 28 Mar 2022 15:40:56 +0100
In-reply-to: <YjtfTHjUHeHvSTgG@yuki>
Message-ID: <87k0cem7fs.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] cgroups: Add first IO controller test
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

>> +
>> +		tst_res(TPASS, "Found %u:%u in io.stat", dev_major, dev_minor);
>> +		TST_EXP_EXPR(rbytes > st_rbytes, "(rbytes=%lu) > (st_rbytes=%lu)", rbytes, st_rbytes);
>> +		TST_EXP_EXPR(wbytes > st_wbytes, "(wbytes=%lu) > (st_wbytes=%lu)", wbytes, st_wbytes);
>> +		TST_EXP_EXPR(rios > st_rios, "(rios=%lu) > (st_rios=%lu)", rios, st_rios);
>> +		TST_EXP_EXPR(wios > st_wios, "(wios=%lu) > (st_wios=%lu)", wios, st_wios);
>
> So we only test here that the counters are updated, that sounds fine for
> a simple test.
>
> Do you plan to try anything for io.max? Maybe something as basic as
> running two concurent processes with very different limits and checking
> that the more limited process transfer less bytes per unit of time?

Yes, although maybe not immediately. In the case of io.max this should
not even require comparing concurrent processes as the limits are simply the
absolute number of bytes or iops performed per second by a particular
group. So we can just set them to a very low value and see that reading
or writing takes longer than when unlimited.

io.cost.qos is more complicated because limits are a proportion of the
overall sibling activity.

>
>> +		goto out;
>> +	}
>
> We do have two very similar copies of this parsing code, maybe we should
> put that into a function, and pack the parameters into a structure o
> avoid copy&paste like this. e.g.
>
> struct iostats {
> 	unsigned long st_rbytes;
> 	unsigned long st_wbytes;
> 	unsigned long st_rios;
> 	unsigned long st_wios;
> };
>
> static int read_iostats(const char *stats,
>                         unsigned int dev_min, unsigned int dev_maj,
> 			struct iostats *iostats);
>

+1

>
>> +	tst_res(TINFO, "io.stat:\n%s", buf);
>> +	tst_res(TFAIL, "Did not find %u:%u in io.stat", dev_major, dev_minor);
>> +out:
>> +	free(buf);
>> +	SAFE_CLOSE(fd);
>> +	SAFE_UNLINK("mnt/dat");
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	char buf[PATH_MAX] = { 0 };
>> +	char *path = SAFE_GETCWD(buf, PATH_MAX - sizeof("mnt") - 1);
>> +	struct mntent *mnt;
>> +	FILE *mntf = setmntent("/proc/self/mounts", "r");
>> +	struct stat st;
>> +
>> +	strcpy(path + strlen(path), "/mnt");
>> +
>> +	if (!mntf) {
>> +		tst_brk(TBROK | TERRNO, "Can't open /proc/self/mounts");
>> +		return;
>> +	}
>> +
>> +	mnt = getmntent(mntf);
>> +	if (!mnt) {
>> +		tst_brk(TBROK | TERRNO, "Can't read mounts or no mounts?");
>> +		return;
>> +	}
>> +
>> +	do {
>> +		if (strcmp(mnt->mnt_dir, path))
>> +			continue;
>> +
>> +		SAFE_STAT(mnt->mnt_fsname, &st);
>> +		dev_major = major(st.st_rdev);
>> +		dev_minor = minor(st.st_rdev);
>> +
>> +		return;
>> +
>> +	} while ((mnt = getmntent(mntf)));
>
> I guess that this should probably go to the test library. We already
> have tst_find_backding_dev() in there which is doing something a bit
> similar. Looking at the code what we do here is to translate a
> mountpoint into a device so it may be something as:
>
> int tst_find_dev_by_mntpoint()

OK, I wasn't sure if to replace tst_find_backing_dev() which doesn't do
what the name suggests to me. The actual device it returns will be some
anonymous virtual block device in many cases. If it is btrfs, then the
"backing device" is probably a real device not an anonymous device
created for the subpartion. OTOH maybe this is what was intended.

>
>> +	tst_brk(TBROK, "Could not find mount device");
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.needs_device = 1,
>> +	.mntpoint = "mnt",
>> +	.mount_device = 1,
>> +	.all_filesystems = 1,
>> +	.skip_filesystems = (const char *const[]){ "ntfs", "tmpfs", NULL },
>> +	.needs_cgroup_ver = TST_CG_V2,
>> +	.needs_cgroup_ctrls = (const char *const[]){ "io", NULL },
>> +};
>> -- 
>> 2.35.1
>> 
>> 
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
