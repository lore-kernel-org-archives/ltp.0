From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 6 May 2021 17:35:01 +0200
Subject: [LTP] LTP Release
In-Reply-To: <YJOYgZNL7/qp5YCN@yuki>
References: <YJOYgZNL7/qp5YCN@yuki>
Message-ID: <5b2dca3e-7b3e-678e-1726-9849c76d766a@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06. 05. 21 9:19, Cyril Hrubis wrote:
> Hi!
> It's about time for another LTP release. So as usuall let's start with
> the list of patches that should go in before the release.
> 
> First of all I will have to fix the docparser JSON string escape patch,
> I will do so ASAP.
> 
> Also I would like to get the CGroup API rewrite in, since that fixes
> real problems and is, as far as I can tell, ready to go.
> 
> The rtnetlink patchset from Martin is nearly ready as well. I would
> apply it as well if we manage to get to final version soon enough.
> 
> That is all for me, if there is anything else please reply ASAP.

Well, I don't really mind if the rtnetlink patches get delayed until
after the release. But just a reminder that I'm planning to resubmit
patch 6 only after the library changes get merged.

On the other hand, I'd like to get the inotify06 fixes into the next
release.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
