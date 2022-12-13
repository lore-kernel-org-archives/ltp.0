Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58EBC4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 19:18:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 66F803CBDE1
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 20:18:52 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B89793CBD96
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 20:18:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 22742600852
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 20:18:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E53912299B;
 Tue, 13 Dec 2022 19:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670959120;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X0IyIMaEAp2T3Vv/b5rSJDsR8keq6tWjzQdx1bKdEsg=;
 b=fTn+6CGQ6TZ4LzqkgL+zIwfeWwNi2Qz0NlGghUMt9//sqP5gnet1N5WYed0SMxQw6kx6iP
 J/xWzo1yCYU1JSXgAXu/mXCs9515Yfr0366IMBNqFwLbNYOYPGgrAh2w6NK0X2vkTUGvY2
 fnT6tGAw49NYCEeKnypL5Qiz1+ZAKG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670959120;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X0IyIMaEAp2T3Vv/b5rSJDsR8keq6tWjzQdx1bKdEsg=;
 b=AuI93W16HfCUsxK2YxzudQDV7wBz7gVsw3jJpI87z2R//iHcgl2sGQrGhkW7VMTjl+zefg
 Kov8bPUwcdo9nkDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A14CF138F9;
 Tue, 13 Dec 2022 19:18:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HbtwJRDQmGM1DAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 13 Dec 2022 19:18:40 +0000
Date: Tue, 13 Dec 2022 20:18:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y5jQDt7A/VmUZp9G@pevik>
References: <20221209141002.15551-1-pvorel@suse.cz>
 <87bko7sinw.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87bko7sinw.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] ci: Add hook to mirror docparse to homepage
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Aleks L <aleksandrosansan@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie,

first, thank you for your review!

> Hello,

> Petr Vorel <pvorel@suse.cz> writes:

> > GitHub Actions git push hook generates metadata HTML and push it
> > to LTP homepage.

> > Hook pushes only if there are actual changes in generated doc.

> IIUC we have to do most of the work to generate the meta data, but then
> don't push it if there is no diff?

> What are we saving with this optimisation?

This saves number of commits which will change nothing.
Because the page itself has also other changes for the web page itself,
which will be buried with these changes.
But sure, I'll remove this check, if considered useless.

If your comment is about to do the detection earlier,
I'd have to do some smart 'git diff'. Could be done with:
git diff $old_commit testcases/ | grep '^+ \* '
in step "Check metadata need to be updated"
(i.e. after both checkouts).


> > NOTE: this change requires to add:

> > 1) Personal Access Token (PAT) to any developer which has write access
> > to homepage git repository [3]. In Developer settings -> Personal access
> > tokens -> Tokens (classic) [4]), where set:
> > Note: GH_PERSONAL_ACCESS_TOKEN
> > Select scopes: public_repo (minimal permission)
> > Expiration: either never or regularly renew.

> > 2) Allow PAT in LTP organisation (I dared to already set it)
> > Iin linux-test-project group -> Settings -> Third-party Access -> Personal
> > access tokens -> Settings [5]
> > select:
> > Allow access via personal access tokens (classic)
> > API and Git access will be allowed using an organization member's personal access token (classic)

> > 3) Add repository action secret to ltp repository
> > IN Settings -> Actions -> New repository secret [6]:
> > name: GH_PERSONAL_ACCESS_TOKEN
> > value: the value of previously created token.

> > Because using token, default permission is just read.

> This seems like a very convoluted process. Can't we just put the
> metadata generation in the docs build and upload the assets as usual?
> I've never had to use a PAT to deploy a github page.

Do you mean to have this Action in linux-test-project.github.com git repo?
What would trigger the build? Some kind of cron behavior?
Using PAT is a weak point thus I'm really open to other solutions.

...
> > +++ b/.github/workflows/metadata-mirror.yml
...
> > +    steps:
> > +      - name: Check secret
> > +        env:
> > +          GH_PERSONAL_ACCESS_TOKEN: ${{ secrets.GH_PERSONAL_ACCESS_TOKEN }}
> > +        run: |
> > +          if [ -z "$GH_PERSONAL_ACCESS_TOKEN" ]; then
> > +            echo "::error::GH_PERSONAL_ACCESS_TOKEN environment variable is not set"
> > +            exit 1
> > +          fi

> Do we not trust Github to set an env variable?
If I delete my PAT, this will catch it. Of course error message could be
improved.

...
> > +      - name: Push generated html metadata to LTP homepage
> > +        env:
> > +          GH_PERSONAL_ACCESS_TOKEN: ${{
> > secrets.GH_PERSONAL_ACCESS_TOKEN }}

> Why put a credential in an env variable anyway? Can we not simply write
> ${{ secrets.GH_PERSONAL_ACCESS_TOKEN }} below?
I can test if it's supported inside "run:", but github hides env content,
thus no big deal to use env. See:
https://github.com/foo-pevik/ltp_foo/actions/runs/3660784474
GH_PERSONAL_ACCESS_TOKEN: ***

https://github.com/foo-pevik/ltp_foo/actions/runs/3660784474/jobs/6188315802
GH_PERSONAL_ACCESS_TOKEN: ***

(Hidden on all places.)

> > +        run: |
...
> > +          printf "metadata.nightly.html: Update to $commit\n\nUpdate metadata.nightly.html to $commit_desc\n" > /tmp/msg
> > +          git commit -F /tmp/msg .
> > +
> > +          echo "::notice::GH_PERSONAL_ACCESS_TOKEN: $GH_PERSONAL_ACCESS_TOKEN"

> Won't this print your PAT for the world to use?
No (described above, see the links of actual run).
> > +          git push
> > https://${GH_PERSONAL_ACCESS_TOKEN}@github.com/linux-test-project/linux-test-project.github.com.git

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
