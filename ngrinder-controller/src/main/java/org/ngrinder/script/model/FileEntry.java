/* 
 * Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License. 
 */
package org.ngrinder.script.model;

import static org.ngrinder.common.util.CollectionUtils.newHashMap;
import static org.ngrinder.common.util.Preconditions.checkNotEmpty;

import java.lang.reflect.Type;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.MapUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.ngrinder.common.util.PathUtil;
import org.ngrinder.model.BaseModel;
import org.ngrinder.model.IFileEntry;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonSerializationContext;
import com.google.gson.JsonSerializer;

/**
 * File entity which will be stored in SVN.
 * 
 * 
 * @author Liu Zhifei
 * @author JunHo Yoon
 * @since 3.0
 */
public class FileEntry extends BaseModel<FileEntry> implements IFileEntry {

	private static final long serialVersionUID = -2422243194192027508L;

	private long fileSize;

	/**
	 * Test url. This File entity works on.. This field is only for the HTML form.
	 */
	private String testURL;

	private String content;

	/**
	 * File properties.
	 */
	private Map<String, String> properties = new HashMap<String, String>();

	/**
	 * Revisions on this entity. This fields are sometimes empty depending on the
	 * {@link FileEntryRepository}.
	 */
	private List<Long> revisions;

	/**
	 * This is mapped to commit comment.
	 */
	private String description;

	private String encoding;

	private byte[] contentBytes;

	private String path;

	private FileType fileType;

	private long revision;

	/**
	 * Get path of entry.
	 * 
	 * @return path
	 */
	public String getPath() {
		return path;
	}

	public String getPathInShort() {
		return PathUtil.getShortPath(path.toString());
	}

	public String getFileName() {
		return FilenameUtils.getName(checkNotEmpty(getPath()));
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getTestURL() {
		return testURL;
	}

	public void setTestURL(String testURL) {
		this.testURL = testURL;
	}

	public byte[] getContentBytes() {
		return contentBytes;
	}

	/**
	 * set content bytes.
	 * 
	 * @param contentBytes
	 *            contentByte.
	 */
	public void setContentBytes(byte[] contentBytes) {
		this.fileSize = contentBytes.length;
		this.contentBytes = contentBytes;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.ngrinder.script.model.IFileEntry#getContent()
	 */
	@Override
	public String getContent() {
		return content;
	}

	/**
	 * Set content in string form.
	 * 
	 * @param content
	 *            content string
	 */
	public void setContent(String content) {
		this.fileSize = content.length();
		this.content = content;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean isEditable() {
		return fileType.getFileCategory().isEditable();
	}

	/**
	 * Get file type. If fileType is set, it returns the set fileType. Otherwise, it tries to detect
	 * the file type by the extension.
	 * 
	 * @return file type.
	 */
	public FileType getFileType() {
		if (fileType == null) {
			fileType = FileType.getFileTypeByExtension(FilenameUtils.getExtension(getPath()));
		}
		return fileType;
	}

	public void setFileType(FileType fileType) {
		this.fileType = fileType;
	}

	public List<Long> getRevisions() {
		return revisions;
	}

	public void setRevisions(List<Long> revisions) {
		this.revisions = revisions;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getEncoding() {
		return encoding;
	}

	public void setEncoding(String encoding) {
		this.encoding = encoding;
	}

	/**
	 * Get current revision.
	 * 
	 * @return the revision
	 */
	public long getRevision() {
		return revision;
	}

	/**
	 * Set current revision.
	 * 
	 * @param revision
	 *            the revision to set
	 */
	public void setRevision(long revision) {
		this.revision = revision;
	}

	/**
	 * Get properties.
	 * 
	 * @return properties, empty map if null.
	 */
	public Map<String, String> getProperties() {
		if (this.properties == null) {
			return newHashMap();
		}
		return this.properties;
	}

	public void setProperties(Map<String, String> properties) {
		this.properties = properties;
	}

	/**
	 * FileEntry to JSON serializer.
	 * 
	 * @author JunHo Yoon
	 * @since 3.2.1
	 */
	public static class FileEntrySerializer implements JsonSerializer<FileEntry> {
		@Override
		public JsonElement serialize(FileEntry fileEntry, Type typeOfSrc, JsonSerializationContext context) {
			JsonObject root = new JsonObject();
			root.addProperty("path", FilenameUtils.separatorsToUnix(fileEntry.getPath()));
			root.addProperty("pathInShort", FilenameUtils.separatorsToUnix(fileEntry.getPathInShort()));
			root.addProperty("revision", fileEntry.getRevision());
			root.addProperty("validated",
							NumberUtils.createInteger(MapUtils.getString(fileEntry.getProperties(), "validated", "0")));
			return root;
		}
	}
}
