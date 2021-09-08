From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Sep 2021 12:44:57 +0200
Subject: [LTP] [COMMITTED] runtest/cve: Fix wrong cve tag
In-Reply-To: <5b7f4a92-983f-2a7b-21f3-f9e2110bc0c2@suse.cz>
References: <1630897958-2160-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <613864D4.5030400@fujitsu.com>
 <5b7f4a92-983f-2a7b-21f3-f9e2110bc0c2@suse.cz>
Message-ID: <YTiUKRnhWh6b6iS9@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > In fact, Look the following url:
> > https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-3609
> > 
> > It said nothing and seems this cve number doesn't exist.
> > 
> > Do you know what happen?
> 
> This vulnerability is tracked under this CVE number in SUSE Bugzilla and
> RedHat security portal:
> https://bugzilla.suse.com/show_bug.cgi?id=1187215
> https://access.redhat.com/security/cve/cve-2021-3609
> 
> I didn't check any "upstream" CVE databases.

Looks like the CVE has been allocated though, so possibly somehow the
the notification that it has been assigned has failed. I guess that
RedHat security team should look into this.

-- 
Cyril Hrubis
chrubis@suse.cz
