From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 27 Apr 2021 12:54:55 +0200
Subject: [LTP] [PATCH 2/2] bpf: Check truncation on 32bit div/mod by zero
In-Reply-To: <87k0oot5sg.fsf@suse.de>
References: <20210426120107.6632-1-rpalethorpe@suse.com>
 <20210426120107.6632-2-rpalethorpe@suse.com>
 <YIfZqZ29H2AN1vqh@pevik> <87k0oot5sg.fsf@suse.de>
Message-ID: <YIftf5pHE2iVmfGn@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> bah, maybe we should just base64 encode doc strings in the JSON?

I do not think that this is a good idea, the main reason why I choose
JSON was because it is human readable...

-- 
Cyril Hrubis
chrubis@suse.cz
