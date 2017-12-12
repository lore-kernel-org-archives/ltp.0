From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Dec 2017 11:20:48 +0100
Subject: [LTP] [PATCH v3] scripts: Dump /proc and /sys
In-Reply-To: <20171212074900.8150-1-rpalethorpe@suse.com>
References: <20171212074900.8150-1-rpalethorpe@suse.com>
Message-ID: <20171212102048.GB12279@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +
> +for i in $(seq $nproc); do
> +    mkfifo "$dump_dir/fifo$i"
> +    ( spawn_dd ) < "$dump_dir/fifo$i" &
> +done
> +
> +count=$nproc
> +for f in $files; do
> +    if [ $count -gt 0 ]; then
> +	count=$((count - 1))
> +    else
> +	count=$nproc
> +    fi
> +    echo "$f" > "$dump_dir/fifo$count"
> +done

We still do have off-by-one here. The fifos are created for $(seq
$nproc) which starts at 1 but the count here goes to 0 so instead of
writing to fifo some we will write to a regular file here for
$count == 0.


Why not just:

count=$nproc
for f in $files; do
	count=$((count - 1))

	if [ $count -lt 1 ]; then
	    count=$nproc
	fi

	...

done


-- 
Cyril Hrubis
chrubis@suse.cz
