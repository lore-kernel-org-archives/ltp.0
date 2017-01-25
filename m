From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 25 Jan 2017 16:30:21 +0300
Subject: [LTP] [PATCH v2 1/2] network: Fix export for some non-bash
	shells
In-Reply-To: <20170123140259.20053-1-pvorel@suse.cz>
References: <20170123140259.20053-1-pvorel@suse.cz>
Message-ID: <1cc08880-38c1-62b2-3248-7f74cd87e8bd@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01/23/2017 05:02 PM, Petr Vorel wrote:
> This fix 'export: -n: bad variable name' for scripts using test_net.sh
> in dash.

Fix setting other variables in test_net.sh and applied. Thanks!
