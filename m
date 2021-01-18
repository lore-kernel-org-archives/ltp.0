From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Jan 2021 12:38:09 +0100
Subject: [LTP] [PATCH 1/1] travis: Temporary workaround for pull rate
 limit
In-Reply-To: <YAVkff08KAIh8l+s@pevik>
References: <20210118081350.21418-1-pvorel@suse.cz>
 <60055B2C.1080607@cn.fujitsu.com> <YAVkff08KAIh8l+s@pevik>
Message-ID: <YAVzIdnJ01YfmcSd@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I think using gcr.io mirror as a temporary solution is OK. But why we
> > not migrate into Github Actions directly? Now, it is time to this
> > release and do we should apply it before release?
> Lack of time on my side (working on other fixes before release).

Let's push this now, since it's important to have travis working when we
are finalizing the release.

Acked-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
