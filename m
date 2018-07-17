From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 17 Jul 2018 04:13:03 -0400 (EDT)
Subject: [LTP] [PATCH] filecaps: Respect TMPDIR environment variable
In-Reply-To: <20180711210336.186949-1-astrachan@google.com>
References: <93480014.31836255.1531299278505.JavaMail.zimbra@redhat.com>
 <20180711210336.186949-1-astrachan@google.com>
Message-ID: <1930824158.33466679.1531815183709.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The filecapstest.sh wrapper script already allowed the /tmp directory to
> be overridden with the TMP environment variable, however doing so had
> no effect on verify_caps_exec because it created its own version of this
> fifo at a hardcoded location under /tmp.
> 
> Change the wrapper script to check for TMPDIR instead of TMP, to match
> the value exported by runltp. Export FIFOFILE, to be used by the test
> binaries invoked by the script.
> 
> Change the print_caps and verify_caps_exec to read FIFOFILE from the
> environment (if it exists). Otherwise, TMPDIR will be read from the
> environment and used to construct the path to the caps_fifo file.
> 
> Signed-off-by: Alistair Strachan <astrachan@google.com>

I moved get_caps_fifo() to common header, changed it to use
getenv() ptr directly when possible and pushed.

Thanks,
Jan



