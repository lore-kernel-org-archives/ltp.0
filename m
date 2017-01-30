From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 30 Jan 2017 16:32:31 +0300
Subject: [LTP] [PATCH 3/3] netstress.c: convert to new library API
In-Reply-To: <20170130131342.GC29227@rei.lan>
References: <1482154595-4641-1-git-send-email-alexey.kodanev@oracle.com>
 <1482154595-4641-3-git-send-email-alexey.kodanev@oracle.com>
 <20170123145734.GC25788@rei.lan>
 <837482ef-0ac4-0a3b-3c4e-598ed6ce96e1@oracle.com>
 <20170130131342.GC29227@rei.lan>
Message-ID: <f4ed5f48-569d-34d6-8cdc-38af12d50359@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 30.01.2017 16:13, Cyril Hrubis wrote:
> Are you sure? SAFE_CLOSE() is a macro which expands to:
> 	do {
> 		safe_close("foo", 42, NULL, (*fd));
> 		(*fd) = -1;
> 	} while (0)

Good! I thought it expands to safe_close() only....

Thanks,
Alexey
