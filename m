From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Jan 2018 11:54:26 +0100
Subject: [LTP] [PATCH] Add missing entry to .gitignore
In-Reply-To: <20180112093230.4093-1-mmoese@suse.de>
References: <20180112093230.4093-1-mmoese@suse.de>
Message-ID: <20180112105426.GB22350@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Good catch, we actually renamed that file recetly and failed to update
the .gitignore entry. I've ammended the patch so that it deletes the
now unused line as well.

Also can you pretty please produce patches with the Signed-off-by: line?

(I've added your Signed-off-by: this time for your before commiting)

-- 
Cyril Hrubis
chrubis@suse.cz
