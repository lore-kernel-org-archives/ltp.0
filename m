Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED30CFD30B
	for <ltp@archiver.kernel.org>; Fri, 11 Oct 2024 09:18:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F9B03C20C9
	for <ltp@archiver.kernel.org>; Fri, 11 Oct 2024 11:18:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDDFB3C20C9
 for <ltp@lists.linux.it>; Fri, 11 Oct 2024 11:18:37 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9AA63641A5F
 for <ltp@lists.linux.it>; Fri, 11 Oct 2024 11:18:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A21121A5F;
 Fri, 11 Oct 2024 09:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728638314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aLTBX5x+H5zZhWqwIueLUHn6yYPcbo1bgG7cX3iiQ4k=;
 b=kJlC30pLmGLGmwT9YQZ4e8rTMHjFO9ltxmDBc5Acv33+SeOb8R6gDuuciOFvZfXTxFAMbb
 sq6CijFNx6sS8o3F+JFTY9EGx2D2IRBCLLgG7luly99s/nqCq2zMCQY9DQIBSJkuAwEM7a
 ULawJPsVGfSZ6KKktRmSuM4Obj1y6lM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728638314;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aLTBX5x+H5zZhWqwIueLUHn6yYPcbo1bgG7cX3iiQ4k=;
 b=62besYYdd410GViZVL4MDvtFAq2DPeW0CPrSTXOzhRyrAgzucoefqJZuxM+rehBeYxQbTO
 EYH05jYTCOvYEXAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kJlC30pL;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=62besYYd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728638314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aLTBX5x+H5zZhWqwIueLUHn6yYPcbo1bgG7cX3iiQ4k=;
 b=kJlC30pLmGLGmwT9YQZ4e8rTMHjFO9ltxmDBc5Acv33+SeOb8R6gDuuciOFvZfXTxFAMbb
 sq6CijFNx6sS8o3F+JFTY9EGx2D2IRBCLLgG7luly99s/nqCq2zMCQY9DQIBSJkuAwEM7a
 ULawJPsVGfSZ6KKktRmSuM4Obj1y6lM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728638314;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aLTBX5x+H5zZhWqwIueLUHn6yYPcbo1bgG7cX3iiQ4k=;
 b=62besYYdd410GViZVL4MDvtFAq2DPeW0CPrSTXOzhRyrAgzucoefqJZuxM+rehBeYxQbTO
 EYH05jYTCOvYEXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 561911370C;
 Fri, 11 Oct 2024 09:18:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y7GqE2rtCGd4KwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Oct 2024 09:18:34 +0000
Date: Fri, 11 Oct 2024 11:17:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZwjtKbWq7tf_7ZOv@yuki.lan>
References: <ZvqQxP9KVW6PqFOo@yuki.lan>
 <CAEemH2fQstWU-MWs+gxZFrqi_ftYbRZzUg1iGQhbAjrqXuqRig@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fQstWU-MWs+gxZFrqi_ftYbRZzUg1iGQhbAjrqXuqRig@mail.gmail.com>
X-Rspamd-Queue-Id: 6A21121A5F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 SEPTEMBER 2024
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

Hi!
> > git shortlog -s -e -n 20240129..
> >
> 
> This should be compared with 20240524.
> But anyway it's not a big deal.

Ah, sorry, I haven't noticed even though the statistics are obviously
doubled, here are the correct data:

git shortlog -s -e -n 20240524..

    93  Petr Vorel <pvorel@suse.cz>
    58  Andrea Cervesato <andrea.cervesato@suse.com>
    22  Xinjian Ma (Fujitsu) <maxj.fnst@fujitsu.com>
    17  Martin Doucha <mdoucha@suse.cz>
    15  Cyril Hrubis <chrubis@suse.cz>
    15  Li Wang <liwang@redhat.com>
     7  Wei Gao <wegao@suse.com>
     6  John Stultz <jstultz@google.com>
     3  Andreas Schwab <schwab@suse.de>
     3  Edward Liaw <edliaw@google.com>
     3  Jan Stancek <jstancek@redhat.com>
     3  Xiao Yang <ice_yangxiao@163.com>
     2  Jiwei Sun <sunjw10@lenovo.com>
     2  Po-Hsu Lin <po-hsu.lin@canonical.com>
     1  Ajay Kaher <ajay.kaher@broadcom.com>
     1  Avinesh Kumar <akumar@suse.de>
     1  Chen Haonan <chen.haonan2@zte.com.cn>
     1  Chuck Lever <chuck.lever@oracle.com>
     1  Haifeng Xu <haifeng.xu@shopee.com>
     1  Jingyi Song <jingyisong@hust.edu.cn>
     1  Kuan-Ying Lee <kuan-ying.lee@canonical.com>
     1  Li Xiaosong <rj45usb@163.com>
     1  Madadi Vineeth Reddy <vineethr@linux.ibm.com>
     1  Nirjhar Roy <nirjhar@linux.ibm.com>
     1  Remi Peuvergne <remi.peuvergne@kaizen-solutions.net>
     1  Sachin P Bappalige <sachinpb@linux.ibm.com>
     1  Shizhao Chen <shichen@redhat.com>
     1  Yiwei Lin <s921975628@gmail.com>
     1  Zizhi Wo <wozizhi@huawei.com>
     1  lufei <lufei@uniontech.com>

git log 20240524.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

     87 Petr Vorel <pvorel@suse.cz>
     87 Cyril Hrubis <chrubis@suse.cz>
     77 Li Wang <liwang@redhat.com>
     28 Avinesh Kumar <akumar@suse.de>
     13 Andrea Cervesato <andrea.cervesato@suse.com>
      4 Martin Doucha <mdoucha@suse.cz>
      3 Wei Gao <wegao@suse.com>
      3 Richard Palethorpe <io@richiejp.com>
      3 Jan Stancek <jstancek@redhat.com>
      3 Jan Kara <jack@suse.cz>
      2 Adrian Huang <ahuang12@lenovo.com>
      1 Po-Hsu Lin <po-hsu.lin@canonical.com>
      1 Amir Goldstein <amir73il@gmail.com>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
