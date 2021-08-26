From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Aug 2021 16:28:05 +0200
Subject: [LTP] [PATCH v2 4/4] Add test for CVE 2018-13405
In-Reply-To: <89e96508-581a-e60c-58cb-37c0c3b3b176@suse.cz>
References: <20210826112212.26394-1-mdoucha@suse.cz>
 <20210826112212.26394-4-mdoucha@suse.cz> <YSeWymK0elcbiqzt@pevik>
 <89e96508-581a-e60c-58cb-37c0c3b3b176@suse.cz>
Message-ID: <YSek9Snd8uZ8PIEY@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> + * Check for possible privilege escalation through creating files with setgid
> >> + * bit set inside a setgid directory owned by a group which the user does not
> >> + * belong to. Fixed in:
> > Maybe this info could be in docparse, but again, that can be fixed during merge.
> 
> Yes, please add the docparse tag during merge.

I will do that for the other two tests as well.

> As for if/else braces, I thought the coding style was to add braces
> around multi-line statements even if it's a single command.

Indeed that's the preferred way.

-- 
Cyril Hrubis
chrubis@suse.cz
